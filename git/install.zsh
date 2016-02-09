#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "git"
  
  print-step "git symlinks..."
  symlink "${base}/gitignore" "${HOME}/.gitignore"
  symlink "${base}/gitconfig" "${HOME}/.gitconfig"

  print-message "remember to update the contents of .gitconfig"
}

main $@

