#!/bin/bash

maxlength=30

# Get all players and their status
players=$(playerctl -l 2>/dev/null)

if [[ -z "$players" ]]; then
    echo '{ "text": "", "tooltip": "No player running" }'
    exit 0
fi

# Find the first active (playing) player
active_player=""
while IFS= read -r player; do
    status=$(playerctl -p "$player" status 2>/dev/null)
    if [[ "$status" == "Playing" ]]; then
        active_player="$player"
        break
    fi
done <<< "$players"

# If no playing player found, use the first player available
if [[ -z "$active_player" ]]; then
    active_player=$(echo "$players" | head -n1)
fi

# Try to fetch metadata from the active player
if ! text=$(playerctl -p "$active_player" metadata --format '{{artist}} - {{title}}' 2>/dev/null); then
    echo '{ "text": "", "tooltip": "No metadata available" }'
    exit 0
fi

# Get the focused window's App ID
focused_app=$(niri msg focused-window 2>/dev/null | grep -o 'App ID: "[^"]*"' | sed 's/App ID: "\(.*\)"/\1/')

# Check if the active player is from the focused window (contains match)
if [[ "$focused_app" == *"$active_player"* ]] || [[ "$active_player" == *"$focused_app"* ]]; then
    echo '{}'
    exit 0
fi

# Special case: chromium player with google-chrome focused window
if [[ "$active_player" == "chromium" && "$focused_app" == "google-chrome" ]]; then
    echo '{}'
    exit 0
fi

# truncate if necessary
if [ ${#text} -gt $maxlength ]; then
    text="${text:0:$((maxlength-3))}..."
fi

# get tooltip separately
tooltip=$(playerctl -p "$active_player" metadata --format '{{playerName}} : {{artist}} - {{title}}' 2>/dev/null)

# escape for JSON
text_escaped=$(printf '%s' "$text" | jq -R .)
tooltip_escaped=$(printf '%s' "$tooltip" | jq -R .)

# print valid JSON
echo "{ \"text\": $text_escaped, \"tooltip\": $tooltip_escaped }"
