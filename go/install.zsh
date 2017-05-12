#!/bin/zsh

main() {

  if ! hash go 2> /dev/null; then
    print-step "installing go..."
    if [[ is-macos ]]; then
      brew install go
    fi
  fi

  restart-shell
}

main $@
