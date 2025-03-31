alias watchexecgotest='watchexec -rc --stop-timeout=1s -- "go test -json ./... | docker run --rm -i ghcr.io/gotesttools/gotestfmt:latest"'
alias gotestwatchexec=watchexecgotest
alias watchexecgolangci-lint-run='watchexec -rc --stop-timeout=1s -- "golangci-lint run --sort-results --color always | head -n$(($(tput lines) - 3))"'
alias golangci-lint-run-watchexec=watchexecgolangci-lint-run
