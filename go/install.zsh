#!/bin/zsh

main() {

  if ! hash go 2> /dev/null; then
    print-step "installing go..."
    if [[ is-macos ]]; then
      bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
      source $HOME/.gvm/scripts/gvm
      gvm install go1.15 && gvm use go1.15
      mkdir $HOME/go 2> /dev/null
    fi
  fi

  restart-shell
}

main $@
