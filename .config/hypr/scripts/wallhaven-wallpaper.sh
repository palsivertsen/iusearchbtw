#!/usr/bin/env bash

set -euo pipefail

# Configuration
WALLPAPER_DIR="$HOME/wallpapers"
API_URL="https://wallhaven.cc/api/v1/search"
MIN_WIDTH=1920
MIN_HEIGHT=1080

# Colors for darker wallpapers (hex values for dark tones)
DARK_COLORS="000000,1a1a1a,2d2d2d,424242,666666"

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

echo "Fetching random wallpaper from Wallhaven..."

# Build API query parameters
PARAMS="atleast=${MIN_WIDTH}x${MIN_HEIGHT}"  # Minimum resolution
PARAMS="${PARAMS}&purity=100"                # SFW only
PARAMS="${PARAMS}&sorting=random"            # Random order
PARAMS="${PARAMS}&order=desc"                # Descending order
PARAMS="${PARAMS}&colors=${DARK_COLORS}"     # Darker colors preferred

# Fetch wallpaper data from API
echo "Querying API: ${API_URL}?${PARAMS}"
API_RESPONSE=$(curl -s "${API_URL}?${PARAMS}" || {
    echo "Error: Failed to fetch from Wallhaven API"
    exit 1
})

# Check if API returned valid JSON
if ! echo "$API_RESPONSE" | jq empty 2>/dev/null; then
    echo "Error: Invalid JSON response from API"
    echo "Response: $API_RESPONSE"
    exit 1
fi

# Extract wallpaper data
WALLPAPER_COUNT=$(echo "$API_RESPONSE" | jq '.data | length')
if [ "$WALLPAPER_COUNT" -eq 0 ]; then
    echo "Error: No wallpapers found matching criteria"
    exit 1
fi

# Get the first (random) wallpaper
WALLPAPER_DATA=$(echo "$API_RESPONSE" | jq '.data[0]')
WALLPAPER_URL=$(echo "$WALLPAPER_DATA" | jq -r '.path')
WALLPAPER_ID=$(echo "$WALLPAPER_DATA" | jq -r '.id')
WALLPAPER_RESOLUTION=$(echo "$WALLPAPER_DATA" | jq -r '.resolution')

echo "Found wallpaper: ID $WALLPAPER_ID (${WALLPAPER_RESOLUTION})"

# Determine file extension from URL
FILE_EXT=$(echo "$WALLPAPER_URL" | sed 's/.*\.//')
WALLPAPER_FILE="${WALLPAPER_DIR}/${WALLPAPER_ID}.${FILE_EXT}"

# Check if wallpaper already exists
if [ -f "$WALLPAPER_FILE" ]; then
    echo "Wallpaper already exists: $WALLPAPER_FILE"
else
    echo "Downloading wallpaper..."
    if curl -L -o "$WALLPAPER_FILE" "$WALLPAPER_URL"; then
        echo "Downloaded: $WALLPAPER_FILE"
    else
        echo "Error: Failed to download wallpaper"
        exit 1
    fi
fi

# Set wallpaper using hyprctl
echo "Setting wallpaper..."
if command -v hyprctl >/dev/null 2>&1; then
    # Get all monitors and set wallpaper for each
    MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
    for monitor in $MONITORS; do
        echo "Setting wallpaper for monitor: $monitor"
        hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER_FILE"
    done
    
    echo "Wallpaper set successfully!"
else
    echo "Warning: hyprctl not found. Wallpaper downloaded but not set."
    echo "Wallpaper location: $WALLPAPER_FILE"
fi