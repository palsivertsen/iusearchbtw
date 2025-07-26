#!/bin/bash

# Get current monitor
current_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Get all workspace IDs that exist
all_workspaces=$(hyprctl workspaces -j | jq -r '.[].id' | sort -n)

# Find first empty workspace ID in valid range (1 to 2147483647)
for (( i=1; i<=2147483647; i++ )); do
    if ! echo "$all_workspaces" | grep -q "^$i$"; then
        # Found an empty workspace ID, switch to it (this creates it on current monitor)
        hyprctl dispatch workspace "$i"
        exit 0
    fi
done

# If we get here, no empty workspace found in valid range
exit 1
