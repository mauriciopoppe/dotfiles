#!/bin/zsh

set -e

local base=${0:h}

main() {
  print-header "neovim"

  print-step "installing neovim..."
  if [[ $OSTYPE =~ ^darwin ]]; then
    if ! formula-exists neovim; then
      brew install neovim
    else
      print-message "neovim already installed"
    fi
  fi

  print-step "neovim symlinks..."

  # if the whole `neovim` folder is symlinked to `~/.config/nvim` then
  # all the metadata created by neovim will also be shown as files of the
  # project
  #
  # To avoid this unwanted behavior just sync some files/folders
  #
  symlink "${base}/init.lua" "${HOME}/.config/nvim/init.lua"
  symlink "${base}/lazy-lock.json" "${HOME}/.config/nvim/lazy-lock.json"
  symlink "${base}/lua" "${HOME}/.config/nvim/lua"

  # This is needed for the tmux theme.
  if [[ ! -f "${HOME}/.theme" ]]; then
    change-theme dark
  fi
}

main $@
