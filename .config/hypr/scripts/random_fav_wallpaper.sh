#!/usr/bin/env bash

set -e

FAV_WALLPAPER_DIR="$HOME/wallpapers/fav"

# Check if fav wallpaper directory exists
if [ ! -d "$FAV_WALLPAPER_DIR" ]; then
    echo "No fav wallpaper directory found at $FAV_WALLPAPER_DIR"
    exit 1
fi

# Find available wallpapers
available_wallpapers=$(find "$FAV_WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) 2>/dev/null)

if [ -z "$available_wallpapers" ]; then
    echo "No wallpapers available in $FAV_WALLPAPER_DIR"
    exit 1
fi

# Select random wallpaper
selected_wallpaper=$(echo "$available_wallpapers" | shuf -n 1)

if [ -n "$selected_wallpaper" ]; then
    echo "Setting wallpaper: $(basename "$selected_wallpaper")"

    # Set wallpaper for all monitors
    for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
        hyprctl hyprpaper wallpaper "$monitor,$selected_wallpaper"
    done
fi
