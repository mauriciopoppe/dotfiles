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

  # link default gemset
  # ln -vfs ${DOTFILES_DIRECTORY}/ruby/default.gems ~/.rvm/gemsets/default.gems

  print-message "next steps: https://github.com/rbenv/rbenv#homebrew-on-macos"
  eval "$(rbenv init -)"
  rbenv install 2.4.2
  rbenv global 2.4.2
}

main $@

