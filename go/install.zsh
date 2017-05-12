#!/bin/zsh

main() {

  print-header "go"

  print-step "installing go..."
  if [[ is-macos ]]; then
    if ! command-exists "go"; then
      brew install go
    fi
    restart-shell
  fi

}

main $@
