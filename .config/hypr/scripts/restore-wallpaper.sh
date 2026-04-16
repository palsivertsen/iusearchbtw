#!/usr/bin/env bash

set -e

LAST_WALLPAPER_FILE="$HOME/.cache/last-wallpaper"

if [ -f "$LAST_WALLPAPER_FILE" ]; then
    wallpaper=$(cat "$LAST_WALLPAPER_FILE")
    if [ -f "$wallpaper" ]; then
        echo "Restoring wallpaper: $(basename "$wallpaper")"
        for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper"
        done
        exit 0
    fi
fi

# Fall back to random favorite wallpaper
echo "No saved wallpaper found, falling back to random favorite"
exec ~/.config/hypr/scripts/random_fav_wallpaper.sh
