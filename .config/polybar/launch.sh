#!/usr/bin/env bash

LOG_DIR=/var/log/polybar/

# Terminate already running bar instances
killall -q polybar

# Launch
for MONITOR in $(xrandr --listactivemonitors | tail -n+2 | grep -Po '[-\w]*$'); do
    export MONITOR
    echo "---" >> $LOG_DIR/main-$MONITOR.log
    polybar -r main 2>&1 >> $LOG_DIR/main-$MONITOR.log & disown
done

echo "Bars launched..."
