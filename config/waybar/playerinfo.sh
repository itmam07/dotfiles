#!/bin/bash

maxlength=35

# Try to fetch metadata safely
if ! text=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null); then
    echo '{ "text": "", "tooltip": "No player running" }'
    exit 0
fi

# Get the focused window's App ID
focused_app=$(niri msg focused-window 2>/dev/null | grep -o 'App ID: "[^"]*"' | sed 's/App ID: "\(.*\)"/\1/')

# Get the current player name
player_name=$(playerctl metadata --format '{{playerName}}' 2>/dev/null)

# Check if the current player is from the focused window (contains match)
if [[ "$focused_app" == *"$player_name"* ]] || [[ "$player_name" == *"$focused_app"* ]]; then
    echo '{}'
    exit 0
fi

# Special case: chromium player with google-chrome focused window
if [[ "$player_name" == "chromium" && "$focused_app" == "google-chrome" ]]; then
    echo '{}'
    exit 0
fi

# truncate if necessary
if [ ${#text} -gt $maxlength ]; then
    text="${text:0:$((maxlength-3))}..."
fi

# get tooltip separately
tooltip=$(playerctl metadata --format '{{playerName}} : {{artist}} - {{title}}' 2>/dev/null)

# escape for JSON
text_escaped=$(printf '%s' "$text" | jq -R .)
tooltip_escaped=$(printf '%s' "$tooltip" | jq -R .)

# print valid JSON
echo "{ \"text\": $text_escaped, \"tooltip\": $tooltip_escaped }"
