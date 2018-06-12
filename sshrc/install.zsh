#!/bin/zsh

local base=${0:h}

main() {
  print-header "sshrc"

  if ! hash sshrc 2> /dev/null; then
    print-step "installing ssshrc..."
    if [[ is-macos ]]; then
      brew install sshrc
    fi
  fi

  symlink "${base}/sshrc" "${HOME}/.sshrc"

  mkdir -p "${HOME}/.sshrc.d"
  # aliases
  symlink "${DOTFILES_DIRECTORY}/zsh/aliases.source.zsh" "${HOME}/.sshrc.d/aliases.zsh"
  # vim
  symlink "${base}/vimrc" "${HOME}/.sshrc.d/.vimrc"
  symlink "${DOTFILES_DIRECTORY}/neovim/config/base.vim" "${HOME}/.sshrc.d/config/base.vim"
  symlink "${DOTFILES_DIRECTORY}/neovim/config/general.vim" "${HOME}/.sshrc.d/config/general.vim"
  symlink "${DOTFILES_DIRECTORY}/neovim/config/mappings.vim" "${HOME}/.sshrc.d/config/mappings.vim"
  symlink "${DOTFILES_DIRECTORY}/neovim/config/autocommand.vim" "${HOME}/.sshrc.d/config/autocommand.vim"
}

main $@
