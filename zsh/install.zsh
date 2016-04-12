#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "zsh"

  print-step "installing zplug..."
  if [[ ! -d ${HOME}/.zplug ]]; then
    git clone https://github.com/b4b4r07/zplug ${HOME}/.zplug
  else
    print-message "zplug already installed"
  fi

  print-step "zsh symlinks..."
  symlink "zsh/zshrc" "${HOME}/.zshrc"

  print-step "changing default shell to zsh..."
  if [[ $SHELL == *"zsh"* ]]; then
    print-message "zsh is already configured as the default shell"
  else
    print-message "setting zsh as your default shell"
    chsh -s /bin/zsh
  fi

  print-step "complete!"

  printf "\n"  
  print-message "restart your session to load the new settings"
  printf "\n\t"
  print-message "$ source ~/.zshrc"
  printf "\n"
}

main $@

