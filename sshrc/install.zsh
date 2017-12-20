#!/bin/zsh

set -e

local base=${0:h}

sync_files() {
  # shell
  symlink "${base}/../zsh/aliases.source.zsh" "${HOME}/.sshrc.d/aliases.source.zsh"

  # vim
  symlink "${base}/../neovim/config/base.vim" "${HOME}/.sshrc.d/base.vim"
  symlink "${base}/../neovim/config/general.vim" "${HOME}/.sshrc.d/general.vim"
  symlink "${base}/../neovim/config/mappings.vim" "${HOME}/.sshrc.d/mappings.vim"
}

main() {
  print-header "sshrc"

  print-step "installing sshrc..."
  if ! command-exists "sshrc"; then
    brew install sshrc
  else
    print-message "sshrc already installed"
  fi

  # TODO: copy vimrc files from neovim/
  print-step "sshrc symlinks..."
  symlink "${base}/.sshrc" "${HOME}/.sshrc"
  symlink "${base}/.sshrc.d" "${HOME}/.sshrc.d"

  print-step "copying boot files to ~/.sshrc.d"
  sync_files

  print-step "complete!"
}

main $@
