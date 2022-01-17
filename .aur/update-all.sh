#!/usr/bin/env bash

set -e

function print_header {
	header="* $@ *"
	border=$(sed 's/./*/g' <<<"$header")

	echo "$border"
	echo "$header"
	echo "$border"
}

for dir in $(find -mindepth 1 -maxdepth 1 -type d); do
	print_header "Updating $dir"
	(
		cd $dir
		git pull
		makepkg -sirc --noconfirm
	)
	echo "Done updating $dir"
done
