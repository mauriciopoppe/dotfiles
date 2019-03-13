#!/bin/zsh

local base=${0:h}

main() {
  print-header "homebrew"

  print-step "brew update"

  brew update

  print-step "brew bundle"

  brew bundle --verbose --file=$DOTFILES_DIRECTORY/homebrew/Brewfile

  # fzf hook
  $(brew --prefix)/opt/fzf/install
}

main $@

