#!/bin/sh

# Get the CPU temperature using `sensors` command (requires `lm-sensors` package)
temp=$(sensors | awk '/Core 0/ {print $3}' | tr -d '+°C')

# If `sensors` output is empty, fallback to another method
if [ -z "$temp" ]; then
    temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1 / 1000}')
fi

# Determine class based on temperature range
if [ "$(echo "$temp >= 80" | bc -l)" -eq 1 ]; then
    class="hot"
elif [ "$(echo "$temp >= 60" | bc -l)" -eq 1 ]; then
    class="warm"
else
    class="cool"
fi

# Output JSON for Waybar
printf '{"text": " %s°C", "class": "%s"}' "$temp" "$class"

