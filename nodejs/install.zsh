#!/bin/zsh

local base=${0:h}

npm-install-if-missing() {
  local package=$1
  if npm list -g --depth=0 | grep -q $package; then
    print-message "$package already installed"
  else
    npm install -g --quiet $package
  fi
}

main() {
  print-header "node"

  print-step "installing n..."
  if is-macos; then
    if ! formula-exists n; then
      brew install n
    else
      print-message "n already installed"
    fi
  else
    export N_PREFIX="$HOME/n"
    if [[ ! -d "$N_PREFIX" ]] then
      curl -L http://git.io/n-install | bash
    else
      print-message "n already installed"
    fi
    [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
  fi

  print-step "updating to the latest version of npm..."
  npm-install-if-missing npm

  print-step "installing node modules..."
  local modules
  modules=(
    # essentials
    eslint                    # lint
    eslint-config-standard    # base config for eslint
    npm-check-updates         # `ncu` checks for updates

    # modules
    live-server               # static server with live-reload
    trash-cli                 # safe alternative to rm
    np                        # better npm publish
    tldr                      # man
    typescript
    typescript-language-server
  )
  for module in $modules; do
    npm-install-if-missing $module
  done

  print-step "module symlinks..."
  symlink "$DOTFILES_DIRECTORY/$base/.eslintrc" "$HOME/.eslintrc"
}

main $@

