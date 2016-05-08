#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "node"

  print-step "installing n..."
  if [[ -z $N_PREFIX ]]; then
    curl -L http://git.io/n-install | bash
  else
    print-message "n already installed"
  fi

  # activate nvm for the current subprocess
  export N_PREFIX="$HOME/n"
  [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

  print-step "updating to the latest version of npm..."
  npm install -g --quiet npm


  print-step "installing node modules..."
  local modules
  modules=(
    # essentials
    bower
    standard                  # lint
    npm-check-updates         # ncu checks for updates
    pnpm                      # high performance npm

    # generators
    yo                        # yeoman
    generator-mnm             # generates source file

    # modules
    devtool                   # run node.js programs inside electron
    conventional-changelog
    live-server               # static server with live-reload
    ghrepo                    # initializes a github repo
    wzrd                      # minimalistic server that browserifies index.js

    # build system/module bundlers
    browserify
    gulp
    webpack
    webpack-dev-server

    # debugger
    # vimdebug - replaced with devtool
  )
  for module in $modules; do
    npm install -g --quiet $module
  done
}

main $@

