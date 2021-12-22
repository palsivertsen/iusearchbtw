#!/usr/bin/env bash

# Screen locking script that blurs the screen.
# Inspired by: https://www.andreafortuna.org/2020/04/09/i3-how-to-make-a-pretty-lock-screen-with-a-four-lines-of-bash-script/

IMAGE=$(mktemp lock-XXX.png)

import -window root $IMAGE
convert $IMAGE -blur 0x5 $IMAGE
i3lock -efi $IMAGE $@
rm $IMAGE
