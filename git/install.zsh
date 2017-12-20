#!/bin/zsh
# set -o xtrace

local base=${0:h}

main() {
  print-header "git"

  # symlink
  # stow -d ${DOTFILES_DIRECTORY} -S ${base}

  print-message "remember to update the contents of ~/.gitconfig and ~/.gitconfig-local"
}

main $@

