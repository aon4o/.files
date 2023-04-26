#!/bin/bash

# HOW TO
#xrandr --output <Monitor 1> --auto --output <Monitor 2> --auto --left-of <Monitor 1>
#xrandr --output <Monitor 3> --auto --same-as <Monitor 2>

# Sets the placement
xrandr --output DP-2 --auto --output DP-0 --auto --right-of DP-2
xrandr --output HDMI-0 --auto --same-as DP-0

# Set the refresh rate of the cool monitor
xrandr --output DP-0 --mode 1920x1080 --rate 239.76
