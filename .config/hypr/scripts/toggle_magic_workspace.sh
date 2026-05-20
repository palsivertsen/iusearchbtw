#!/bin/bash
WIN_WS=$(hyprctl activewindow -j | jq -r '.workspace.name')
if [ "$WIN_WS" = "special:magic" ]; then
    MONITOR_WS=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
    hyprctl dispatch movetoworkspace "$MONITOR_WS"
else
    hyprctl dispatch movetoworkspace special:magic
fi
