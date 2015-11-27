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

  # activate nvm for the current subprocess
  [[ -s ${HOME}/.rvm/scripts/rvm ]] && . ${HOME}/.rvm/scripts/rvm

  print-step "installing ruby 2.1.1"
  rvm install 2.1.1

  # NOTE: first time I got http://stackoverflow.com/questions/10585002/zsh-complains-about-rvm-rvm-cleanse-variables-function-definition-file-not-fo
  rvm use ruby-2.1.1

  # essential gems
  print-step "installing gems..."

  local gems
  gems=(
    rake
    jekyll
    travis
  )
  for gem in $gems; do
    gem install $gem
  done
}

main $@

