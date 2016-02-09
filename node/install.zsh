#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  # version to install 4.2
  local NODE_VERSION=${1:-4.2.3}

  print-header "node"

  print-step "installing nvm..."
  if [[ ! -d ${HOME}/.nvm ]]; then
    git clone https://github.com/creationix/nvm.git ${HOME}/.nvm
  else
    print-message "nvm already installed"
  fi

  # activate nvm for the current subprocess
  NVM_DIR="${HOME}/.nvm"
  [[ -s $NVM_DIR/nvm.sh ]] && . "$NVM_DIR/nvm.sh"

  print-step "installing node ${NODE_VERSION}..."
  nvm install ${NODE_VERSION}

  print-step "making ${NODE_VERSION} the default node..."
  nvm use ${NODE_VERSION}
  nvm alias default ${NODE_VERSION}

  print-step "updating to the latest version of npm..."
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

