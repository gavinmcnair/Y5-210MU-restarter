#! /opt/homebrew/bin/python3

import requests
import time
import socket

# Constants for router login and reboot
ROUTER_URL = 'https://192.168.0.1'
LOGIN_ENDPOINT = '/web/v1/user/login'
REBOOT_ENDPOINT = '/web/v1/setting/system/maintenance/reboot'
USERNAME = 'user'
PASSWORD = 'PASSWORDHERE'

# Function to check internet connectivity
def is_internet_active():
    try:
        # Connect to Google's DNS server
        socket.create_connection(("8.8.8.8", 53), timeout=5)
        return True
    except OSError:
        return False

# Function to log in to the router and execute a reboot
def reboot_router():
    with requests.Session() as session:
        # Login data
        login_data = {
            "username": USERNAME,
            "password": PASSWORD
        }
        
        # Bypass SSL verification warnings
        requests.packages.urllib3.disable_warnings(
            requests.packages.urllib3.exceptions.InsecureRequestWarning
        )

        # Send login request
        login_response = session.post(
            f"{ROUTER_URL}{LOGIN_ENDPOINT}",
            json=login_data,
            verify=False
        )

        if login_response.status_code == 200 and login_response.json().get('code') == 200:
            auth_token = login_response.json()['data']['Authorization']

            # Headers for the reboot request
            headers = {
                'Accept': 'application/json',
                'Authorization': auth_token
            }

            # Send reboot request
            reboot_response = session.post(
                f"{ROUTER_URL}{REBOOT_ENDPOINT}",
                headers=headers,
                verify=False
            )

            if reboot_response.status_code == 200:
                print("Router reboot initiated successfully.")
            else:
                print("Failed to initiate router reboot.")
        else:
            print("Login failed.")

# Main function that checks internet connectivity and reboots if necessary
def main():
    while True:
        if not is_internet_active():
            print("Internet is down. Attempting to reboot the router...")
            reboot_router()
        else:
            print("Internet is active.")
        
        # Wait 60 seconds before checking again
        time.sleep(60)

if __name__ == "__main__":
    main()

