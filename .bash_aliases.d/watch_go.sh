alias watchexecgotest='watchexec -rc --stop-timeout=1s -- "go test -json ./... | docker run -i ghcr.io/gotesttools/gotestfmt:latest"'
alias gotestwatchexec=watchexecgotest
alias watchexecgolangcilint='watchexec -rc --stop-timeout=1s -- "golangci-lint run --sort-results --color always | head -n$(($(tput lines) - 3))"'
alias golangcilitwatchexec=watchexecgolangcilint
