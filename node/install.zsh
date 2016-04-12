#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "node"

  print-step "installing n-install..."
  if [[ -z $N_PREFIX ]]; then
    curl -L http://git.io/n-install | bash
  else
    print-message "n already installed"
  fi

  # activate nvm for the current subprocess
  export N_PREFIX="$HOME/n"
  [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

  # print-step "updating to the latest version of npm..."
  npm install -g --quiet npm

  # npm global modules
  print-step "installing node modules..."

  local modules
  modules=(
    # osx
    trash-cli
    modhelp

    # module helpers
    browserify
    bower
    gulp
    standard
    live-server
    conventional-changelog
    ghrepo
    yo
    wzrd
    generator-mnm

    # debugger
    vimdebug
  )
  for module in $modules; do
    npm install -g --quiet $module
  done
}

main $@

