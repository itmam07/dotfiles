#!/bin/bash

maxlength=35

# Try to fetch metadata safely
if ! text=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null); then
    echo '{ "text": "", "tooltip": "No player running" }'
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
