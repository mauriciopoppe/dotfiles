#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "homebrew"

  print-step "brew update"

  brew update

  print-step "brew bundle"

  brew bundle --file=$DOTFILES_DIRECTORY/homebrew/Brewfile
}

main $@

