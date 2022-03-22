#!/usr/bin/env bash

# Screen locking script that blurs the screen.
# Inspired by: https://www.andreafortuna.org/2020/04/09/i3-how-to-make-a-pretty-lock-screen-with-a-four-lines-of-bash-script/

IMAGE=$(mktemp lock-XXX.png)

import -window root $IMAGE
convert -scale 10% -blur 0x1 -resize 1000% $IMAGE $IMAGE
i3lock -efi $IMAGE $@
rm $IMAGE
