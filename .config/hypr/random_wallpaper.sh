#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/wallpapers"

# Get monitor information in JSON format
MONITORS=$(hyprctl monitors -j)

# Loop through each monitor
echo "$MONITORS" | jq -r '.[] | "\(.name) \(.width) \(.height)"' | while read -r monitor_name width height; do
    echo "Processing monitor: $monitor_name (${width}x${height})"
    
    # Check if wallpaper directory exists for this resolution
    resolution_dir="$WALLPAPER_DIR/$width/$height"
    if [ ! -d "$resolution_dir" ]; then
        echo "No wallpaper directory found for resolution ${width}x${height}"
        continue
    fi
    
    # Get current wallpaper for this monitor
    current_wallpaper=$(hyprctl hyprpaper listloaded | grep -o '[^,]*$' | xargs basename 2>/dev/null || echo "")
    
    # Find available wallpapers excluding current one
    available_wallpapers=$(find "$resolution_dir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) ! -name "$current_wallpaper" 2>/dev/null)
    
    if [ -z "$available_wallpapers" ]; then
        echo "No wallpapers available for resolution ${width}x${height}"
        continue
    fi
    
    # Select random wallpaper
    selected_wallpaper=$(echo "$available_wallpapers" | shuf -n 1)
    
    if [ -n "$selected_wallpaper" ]; then
        echo "Setting wallpaper for $monitor_name: $(basename "$selected_wallpaper")"
        
        # Set wallpaper for the specific monitor using reload
        hyprctl hyprpaper reload "$monitor_name,$selected_wallpaper"
    fi
done