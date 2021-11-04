#!/usr/bin/env bash

set -e

SAVE_FILE="pkg.save"

pkg_print () {
	pacman -Qqe
}

pkg_save () {
	pkg_print > "$SAVE_FILE"
}

pkg_restore () {
	sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort "$SAVE_FILE"))
}

pkg_clean () {
	sudo pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort "$SAVE_FILE"))
}

case "$1" in
	"print")
		pkg_print
		;;
	"save")
		pkg_save
		;;
	"restore")
		pkg_restore
		;;
	"clean")
		pkg_clean
		;;
	*)
		echo "Usage: $0 [ print | save | restore ]"
		;;
esac
