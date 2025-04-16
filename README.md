# 3 (Three) Outdoor router Y5-210MU Restarter

## Summary

The Y5-210MU is a fabulous router created by Greenpacket let down only because it disconnects from the mobile network and doesnt reconnect.

Three deny there is an issue but it has been experienced by many people. Most importantly this is entirely a software issue and is totally fixable by Three and Greenpacket if they had the desire to. Its probably only 1 or 2 lines of bad code.

Inside the logs directory is a dump of the logs in case Three or Greenpacket want to fix the issue. (Don't worry. It contains no passwords)

Here are some of the threads about the problem 

   * https://community.three.co.uk/t5/Broadband/5G-Outdoor-hub-Y5-210MU-connection-Issue/m-p/41466
   * https://community.three.co.uk/t5/Broadband/Drop-out-problems-with-new-Three-outdoor-hub-Y5-210MU/m-p/42718
   * https://www.ispreview.co.uk/talk/threads/drop-out-problems-with-new-three-outdoor-hub-y5-210mu.42890/
   * https://www.ispreview.co.uk/talk/threads/three-outdoor-hub-greenpacket-y5-210mu-firmware-questions.42863/
   * https://www.ispreview.co.uk/talk/threads/new-three-outdoor-hub-router.42464/
   * https://www.reddit.com/r/UKmobilenetworks/comments/1g9cvy0/3_home_broadband_outdoor_hub_tried_to_buy_but/
   * https://community.three.co.uk/t5/Broadband/Outdoor-hub-drop-outs/m-p/48402


## Solution

The script included needs to have YOUR username and password for the interface. It checks the internet connectivity and on failure it issues a reboot via the API.

I run mine on a Raspberry Pi which also has home assistant inside a backgrounded tmux session but it could be packaged properly.

Please give it a try and give feedback.

## How to run

Ensure Python is installed. The script only needs the standard libraries. Ensure that `check_and_reboot.py` has been added and execute it.

You might need to change the first line if your python executable is in another location or is just named `python` and you will also need to replace the username and password with your own.


### Example of execution

```
./check_and_reboot.py
```

or 

```
python ./check_and_reboot.py
```

### Running inside tmux

To run in `tmux` ensure it is installed and run

```
tmux new-session -d -s check_and_reboot './check_and_reboot.py >> restart.log &'
```

The tmux docs are available [here](https://github.com/tmux/tmux/wiki) and let you connect to and alter the session

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
