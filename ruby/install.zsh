#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "ruby"

  print-step "installing rvm..."
  if [[ ! -d ${HOME}/.rvm ]]; then
    \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
  else
    print-message "rvm already installed"
  fi

  # activate rvm for the current subprocess
  [[ -s ${HOME}/.rvm/scripts/rvm ]] && . ${HOME}/.rvm/scripts/rvm

  # link default gemset
  ln -vfs ${DOTFILES_DIRECTORY}/ruby/default.gems ~/.rvm/gemsets/default.gems

  print-step "installing ruby 2.1.1"
  rvm install 2.1.1
  rvm use ruby-2.1.1
}

main $@

