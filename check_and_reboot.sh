#!/usr/bin/python3

import requests
import time
import socket
from datetime import datetime

# Constants for router login and reboot
ROUTER_URL = 'https://192.168.0.1'
LOGIN_ENDPOINT = '/web/v1/user/login'
REBOOT_ENDPOINT = '/web/v1/setting/system/maintenance/reboot'
USERNAME = 'user'
PASSWORD = 'PASSWORDHERE'

# Initialize reboot counter
reboot_count = 0

# Delay counter after a reboot
reboot_delay_iterations = 0

# Function to check internet connectivity
def is_internet_active():
    try:
        # Connect to Google's DNS server
        socket.create_connection(("8.8.8.8", 53), timeout=5)
        return True
    except OSError:
        return False

# Function to log in to the router and execute a reboot
def login_and_reboot():
    global reboot_count
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

            reboot_count += 1
            if reboot_response.status_code == 200:
                print(f"Router reboot initiated successfully at {datetime.now()}. Reboot count: {reboot_count}.")
                return True
            else:
                print(f"Failed to initiate router reboot at {datetime.now()}.")

        else:
            print(f"Login failed at {datetime.now()}.")
    
    return False

# Main function that checks internet connectivity and reboots if necessary
def main():
    global reboot_delay_iterations
    while True:
        if reboot_delay_iterations > 0:
            print('R', end='', flush=True)
            reboot_delay_iterations -= 1
        else:
            if not is_internet_active():
                print(f"\nInternet is down. Attempting to reboot the router at {datetime.now()}...")
                if login_and_reboot():
                    reboot_delay_iterations = 3  # Set delay iterations after a reboot
            else:
                print('.', end='', flush=True)  # Print a single dot if internet is active
        
        # Wait 60 seconds before checking again
        time.sleep(60)

if __name__ == "__main__":
    main()

