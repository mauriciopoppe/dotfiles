#!/bin/zsh

local base=${0:h}

main() {
  print-header "homebrew"

  print-step "brew update"

  brew update

  print-step "brew bundle"

  # the bundle was created with `brew bundle dump`
  brew bundle --verbose --file=$DOTFILES_DIRECTORY/homebrew/Brewfile --no-upgrade
}

main $@

