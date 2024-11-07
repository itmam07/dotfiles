#!/bin/bash

# Check if HDMI-1-0 is connected
status=$(xrandr --query | grep "HDMI-1-0 connected")

if [[ -z $status ]]; then
  echo "HDMI-1-0 is disconnected."
  exit 1
fi

# Check if HDMI-1-0 is currently active (on)
output_status=$(xrandr --query | grep "HDMI-1-0 connected" | grep -o "[0-9]\+x[0-9]\+")

if [[ -z $output_status ]]; then
  # If HDMI-1-0 is off (no valid resolution), turn it on
  echo "Turning HDMI-1-0 on."
  xrandr --auto
else
  # If HDMI-1-0 is on (has a valid resolution), turn it off
  echo "Turning HDMI-1-0 off."
  xrandr --output HDMI-1-0 --off
fi

