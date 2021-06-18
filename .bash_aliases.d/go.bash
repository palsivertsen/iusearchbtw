alias gotest='go test ./... --failfast; while inotifywait -rq --exclude "\.git" -e modify -e  close_write -e move -e create -e delete .; do clear; sleep .1; go test  ./... --failfast; done'
