#!/usr/bin/env bash

# Screen locking script that blurs the screen.
# Inspired by: https://www.andreafortuna.org/2020/04/09/i3-how-to-make-a-pretty-lock-screen-with-a-four-lines-of-bash-script/

IMAGE=$(mktemp lock-XXX.png)

# disable notifications
dunstctl set-paused true

import -window root $IMAGE
convert -scale 10% -blur 0x1 -resize 1000% $IMAGE $IMAGE
i3lock -nefi $IMAGE $@
rm $IMAGE

# enable notifications
dunstctl set-paused false
