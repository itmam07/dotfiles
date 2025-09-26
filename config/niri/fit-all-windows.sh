#!/bin/sh

# Script to fit all windows in the current workspace into view
# This script uses niri msg to get window information and resize them

# Check if niri msg is available
if ! command -v niri >/dev/null 2>&1; then
    notify-send "Error" "niri command not found" 2>/dev/null || echo "Error: niri command not found"
    exit 1
fi

# Check dependencies
if ! command -v bc >/dev/null 2>&1; then
    notify-send "Error" "bc not found - please install bc" 2>/dev/null || echo "Error: bc not found"
    exit 1
fi

# Get current workspace info and windows
workspace_info=$(niri msg windows 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$workspace_info" ]; then
    notify-send "Error" "Failed to get window information from niri" 2>/dev/null || echo "Error: Failed to get window information"
    exit 1
fi

# Find the current workspace ID and remember the originally focused window
originally_focused_window=$(echo "$workspace_info" | grep -B 5 "(focused)" | grep "Window ID" | tail -1 | sed 's/Window ID \([0-9]*\).*/\1/')
current_workspace=$(echo "$workspace_info" | grep -A 10 "(focused)" | grep "Workspace ID:" | head -1 | sed 's/.*Workspace ID: //')

if [ -z "$current_workspace" ]; then
    notify-send "Error" "Could not determine current workspace" 2>/dev/null || echo "Error: Could not determine current workspace"
    exit 1
fi

if [ -z "$originally_focused_window" ]; then
    notify-send "Error" "Could not determine originally focused window" 2>/dev/null || echo "Error: Could not determine originally focused window"
    exit 1
fi

# Get all window IDs and their info for the current workspace (non-floating)
temp_file="/tmp/niri_windows_$$"
echo "$workspace_info" > "$temp_file"

# Find all windows in the current workspace that are not floating
current_ws_windows=""
window_id=""
is_current_workspace=false
is_floating=false

while IFS= read -r line; do
    case "$line" in
        "Window ID"*)
            # Extract window ID
            window_id=$(echo "$line" | sed 's/Window ID \([0-9]*\).*/\1/')
            is_current_workspace=false
            is_floating=false
            ;;
        *"Workspace ID: $current_workspace")
            is_current_workspace=true
            ;;
        *"Is floating: yes")
            is_floating=true
            ;;
        *"Scrolling position: column"*)
            if [ "$is_current_workspace" = true ] && [ "$is_floating" = false ]; then
                column_num=$(echo "$line" | sed 's/.*column \([0-9]*\).*/\1/')
                current_ws_windows="$current_ws_windows$window_id:$column_num "
            fi
            ;;
    esac
done < "$temp_file"

rm -f "$temp_file"

if [ -z "$current_ws_windows" ]; then
    notify-send "Info" "No tiling windows found in current workspace" 2>/dev/null || echo "Info: No tiling windows found"
    exit 0
fi

# Count unique columns
unique_columns=$(echo "$current_ws_windows" | tr ' ' '\n' | grep -v '^$' | cut -d: -f2 | sort -u | wc -l)

if [ "$unique_columns" -eq 1 ]; then
    notify-send "Info" "Only one column in workspace, no resizing needed" 2>/dev/null || echo "Info: Only one column, no resizing needed"
    exit 0
fi

# Calculate target width as percentage for equal distribution
target_width_percent=$(echo "scale=0; 100 / $unique_columns" | bc 2>/dev/null)

if [ -z "$target_width_percent" ]; then
    notify-send "Error" "Failed to calculate target width" 2>/dev/null || echo "Error: Failed to calculate target width"
    exit 1
fi

# Get one window ID from each unique column
window_ids_to_resize=""
processed_columns=""
first_window_id=""

for entry in $current_ws_windows; do
    if [ -z "$entry" ]; then continue; fi
    
    window_id=$(echo "$entry" | cut -d: -f1)
    column_num=$(echo "$entry" | cut -d: -f2)
    
    # Check if we already processed this column
    if ! echo "$processed_columns" | grep -q " $column_num "; then
        window_ids_to_resize="$window_ids_to_resize$window_id "
        processed_columns="$processed_columns $column_num "
        
        # Remember the first window for smoother experience
        if [ -z "$first_window_id" ]; then
            first_window_id="$window_id"
        fi
    fi
done

if [ -z "$window_ids_to_resize" ]; then
    notify-send "Error" "No window IDs found for resizing" 2>/dev/null || echo "Error: No window IDs found for resizing"
    exit 1
fi

# Focus the first window for smoother visual experience
if [ -n "$first_window_id" ]; then
    niri msg action focus-window --id "$first_window_id" >/dev/null 2>&1
    # Small delay for smoother visual transition
    # sleep 0.05
fi

# Resize each column to the calculated width
success_count=0
for window_id in $window_ids_to_resize; do
    if [ -z "$window_id" ]; then continue; fi
    
    # Focus the window first, then set its column width
    if niri msg action focus-window --id "$window_id" >/dev/null 2>&1; then
        if niri msg action set-column-width "${target_width_percent}%" >/dev/null 2>&1; then
            success_count=$((success_count + 1))
        fi
    fi
done

if [ "$success_count" -gt 0 ]; then
    # Small delay before restoring original focus for smoother transition
    sleep 0.05
    
    # Restore focus to the originally focused window
    if niri msg action focus-window --id "$originally_focused_window" >/dev/null 2>&1; then
        notify-send "Window Layout" "Fitted $unique_columns columns to ${target_width_percent}% width each" 2>/dev/null || echo "Fitted $unique_columns columns to ${target_width_percent}% width each"
    else
        notify-send "Window Layout" "Fitted $unique_columns columns to ${target_width_percent}% width each (focus restore failed)" 2>/dev/null || echo "Fitted $unique_columns columns to ${target_width_percent}% width each (focus restore failed)"
    fi
else
    notify-send "Error" "Failed to resize any columns" 2>/dev/null || echo "Error: Failed to resize any columns"
    exit 1
fi
