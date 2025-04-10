# 3 (Three) Outdoor router Y5-210MU Restarter

## Summary

The Y5-210MU is a fabulous router created by Greenpacket let down only because it disconnects from the mobile network and doesnt reconnect.

Three deny there is an issue but it has been experienced by many people. Most importantly this is entirely a software issue and is totally fixable by Three and Greenpacket if they had the desire to. Its probably only 1 or 2 lines of bad code.

## Solution

The script included needs to have YOUR username and password for the interface. It checks the internet connectivity and on failure it issues a reboot via the API.

I run mine on a Raspberry Pi which also has home assistant inside a backgrounded tmux session but it could be packaged properly.

Please give it a try and give feedback.

## Output

Here is an excerpt of log output showing the issue and how frequent it is. Sometimes i can have 5 dropouts in a day which would normally fail to recover

```
Internet is down. Attempting to reboot the router at 2025-04-09 09:52:38.281694...
Router reboot initiated successfully at 2025-04-09 09:52:38.515298. Reboot count: 4.
RRR...............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
Internet is down. Attempting to reboot the router at 2025-04-09 21:40:35.488191...
Login failed at 2025-04-09 21:40:35.585581.

Internet is down. Attempting to reboot the router at 2025-04-09 21:41:35.656566...
Login failed at 2025-04-09 21:41:35.759268.

Internet is down. Attempting to reboot the router at 2025-04-09 21:42:35.822482...
Router reboot initiated successfully at 2025-04-09 21:42:36.050869. Reboot count: 5.
RRR..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
```

## Contributing

Please raise and issue or a PR if you have improved this.

## New features

   * Reboot delay. On reboot stop timer for 3 iterations and print R to indicate rebooting. We dont want to reboot before the router comes online
