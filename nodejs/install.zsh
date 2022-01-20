#!/bin/zsh

local base=${0:h}

main() {
  print-header "node"

  print-step "installing n..."
  export N_PREFIX="$HOME/n"
  if [[ ! -d "$N_PREFIX" ]] then
    curl -L http://git.io/n-install | bash
  else
    print-message "n already installed"
  fi

  [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

  print-step "updating to the latest version of npm..."
  npm install -g --quiet npm

  print-step "installing node modules..."
  local modules
  modules=(
    # essentials
    standard                  # lint
    npm-check-updates         # `ncu` checks for updates

    # modules
    live-server               # static server with live-reload
    trash-cli                 # safe alternative to rm
    np                        # better npm publish
    tldr                      # man
  )
  npm install -g --quiet ${modules[@]}

  print-step "module symlinks..."
  symlink "$DOTFILES_DIRECTORY/$base/.czrc" "$HOME/.czrc"
  symlink "$DOTFILES_DIRECTORY/$base/.tern-project" "$HOME/.tern-project"
}

main $@

