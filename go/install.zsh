#!/bin/zsh

main() {

  if ! hash go 2> /dev/null; then
    print-step "installing go..."
    if [[ is-macos ]]; then
      brew install go
      mkdir $HOME/go 2> /dev/null
    fi
  fi

  restart-shell
}

main $@
