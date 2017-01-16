#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "zsh"

  print-step "zsh symlinks..."
  symlink "zsh/zshrc" "${HOME}/.zshrc"

  print-step "complete!"

  printf "\n"  
  print-message "restart your session to load the new settings"
  printf "\n\t"
  print-message "$ source ~/.zshrc"
  printf "\n"
}

main $@

