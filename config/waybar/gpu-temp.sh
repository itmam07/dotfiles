#!/bin/sh

temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | awk '{print $1}')

if [ "$temp" -ge 70 ]; then
    class="hot"
elif [ "$temp" -ge 50 ]; then
    class="warm"
else
    class="cool"
fi

printf '{"text": " %s°C", "class": "%s"}' "$temp" "$class"

