#!/bin/zsh

local base=${0:h}

main() {
  print-header "ruby"

  print-step "installing rbenv..."
  if ! command-exists "rbenv"; then
    brew install rbenv
  else
    print-message "rbenv already installed"
  fi

  print-message "next steps: https://github.com/rbenv/rbenv#homebrew-on-macos"
  eval "$(rbenv init -)"
  rbenv install 2.7.2
  rbenv global 2.7.2

  print-message "Close your Terminal window and open a new one so your changes take effect"
}

main $@

