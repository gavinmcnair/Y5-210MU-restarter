# 3 (Three) Outdoor router Y5-210MU Restarter

## Summary

The Y5-210MU is a fabulous router created by Greenpacket let down only because it disconnects from the mobile network and doesnt reconnect.

Three deny there is an issue but it has been experienced by many people.

## Solution

The script included needs to have YOUR username and password for the interface. It checks the internet connectivity and on failure it issues a reboot via the API.

I run mine on a Raspberry Pi which also has home assistant inside a backgrounded tmux session but it could be packaged properly.

Please give it a try and give feedback.

## Contributing

Please raise and issue or a PR if you have improved this.

## New features

   * Reboot delay. On reboot stop timer for 3 iterations and print R to indicate rebooting. We dont want to reboot before the router comes online
