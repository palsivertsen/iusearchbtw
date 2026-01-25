alias cdmktemp='cd $(mktemp -d)'
cdmkdir () {
  mkdir -p "$1" && cd "$1"
}
