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
    standard-format           # formats the easy cases
    npm-check-updates         # `ncu` checks for updates
    pnpm                      # high performance npm

    # generators
    yo                        # yeoman
    generator-mnm             # generates source files

    # modules
    devtool                   # run node.js programs inside electron
    conventional-changelog    # generates a changelog out of commits
    commitizen                # git prompt
    cz-conventional-changelog # conventional changelog adapter for commitizen
    live-server               # static server with live-reload
    ghrepo                    # initializes a github repo
    budo                      # minimalistic server that browserifies index.js
    trash-cli                 # safe alternative to rm
    np                        # better npm publish
    gzip-size-cli             # gzip size
    pretty-bytes-cli          # display size for humans
    typescript

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

  print-step "module symlinks..."
  symlink "${base}/czrc" "~/.czrc"
}

main $@

