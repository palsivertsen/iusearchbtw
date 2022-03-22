#!/usr/bin/env bash


gotest() {
 	while : ; do
		clear
		go test ./... --failfast "$@"
		inotifywait -rq --exclude "\.git" -e modify -e  close_write -e move -e create -e delete .
	 	sleep .1
 	done
}
