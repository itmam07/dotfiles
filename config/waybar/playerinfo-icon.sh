#!/bin/bash

# Player icons - you can customize these icons
declare -A player_icons
player_icons["spotify"]=" "           # Spotify icon (replace with your preferred icon)
player_icons["youtube_music"]=" "     # YouTube Music icon (replace with your preferred icon)
player_icons["chrome"]=" "            # Chrome icon (replace with your preferred icon)
player_icons["chromium"]=" "          # Chromium icon (replace with your preferred icon)
player_icons["google-chrome"]=" "     # Google Chrome icon (replace with your preferred icon)
player_icons["default"]=" "           # Generic player icon (replace with your preferred icon)

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

# Get the appropriate icon for the player using regex matching
icon="${player_icons[default]}"  # Default fallback

if [[ "$active_player" =~ spotify ]]; then
    icon="${player_icons[spotify]}"
elif [[ "$active_player" =~ youtube.*music|music.*youtube ]]; then
    icon="${player_icons[youtube_music]}"
elif [[ "$active_player" =~ chrome|chromium ]]; then
    icon="${player_icons[chrome]}"
fi

# Get tooltip with artist - title
tooltip=$(playerctl -p "$active_player" metadata --format '{{artist}} - {{title}}' 2>/dev/null)
if [[ -z "$tooltip" ]]; then
    tooltip="No metadata available"
fi

# escape for JSON
icon_escaped=$(printf '%s' "$icon" | jq -R .)
tooltip_escaped=$(printf '%s' "$tooltip" | jq -R .)

# print valid JSON
echo "{ \"text\": $icon_escaped, \"tooltip\": $tooltip_escaped }"
