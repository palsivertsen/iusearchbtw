alias watchgo='watchexec -rc --stop-timeout=1s -- "GOEXPERIMENT=rangefunc go test ./... && golangci-lint run --sort-results --color always | head -n100"'
alias gowatch=watchgo
