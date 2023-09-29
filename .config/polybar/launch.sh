#!/usr/bin/env bash

LOG_DIR=/var/log/polybar

# Terminate already running bar instances
killall -wq polybar

# Launch
export MONITOR
for MONITOR in $(xrandr --listactivemonitors | tail -n+2 | grep -Po '[-\w]*$'); do
    echo "---" >> "$LOG_DIR/main-$MONITOR.log"
    polybar -r main >> "$LOG_DIR/main-$MONITOR.log" 2>&1 &
done

echo "Bars launched..."
