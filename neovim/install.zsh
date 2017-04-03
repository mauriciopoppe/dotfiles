#!/bin/zsh

set -e

local base=${0:h}

-nvim-venv() {
  # Declare a base path for both virtual environments
  venv="$HOME/.cache/vim/venv"

  # Try to detect virtualenv's executable names
  vrenv=virtualenv

  # Ensure python 2/3 virtual environments
  [ -d "$venv" ] || mkdir -p "$venv"
  [ -d "$venv/neovim" ] || $vrenv "$venv/neovim"

  # Install or upgrade dependencies
  "$venv/neovim/bin/pip" install -U neovim PyYAML
}

-install-vim-plug() {
  if [[ ! -e $1 ]]; then
    curl -fLo $1 --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    print-message "vim-plug already installed"
  fi
}

main() {
  print-header "neovim"

  print-step "installing neovim..."
  if ! formula-exists neovim; then
    brew install neovim/neovim/neovim
  else
    print-message "neovim already installed"
  fi

  print-step "installing neovim python package..."
  -nvim-venv

  print-step "neovim symlinks..."

  # if the whole `neovim` folder is symlinked to `~/.config/nvim` then
  # all the metadata created by neovim will also be shown as files of the
  # project
  #
  # To avoid this unwanted behavior just sync some files/folders
  #
  symlink "${base}/init.vim" "${HOME}/.config/nvim/init.vim"
  # symlink "${base}/plugin/utils.vim" "${HOME}/.config/nvim/plugin/utils.vim"
  # symlink "${base}/UltiSnips" "${HOME}/.config/nvim/UltiSnips"
  symlink "${base}/config" "${HOME}/.config/nvim/config"

  # print-step "installing plugins..."
  # nvim +PlugInstall +qall

  # NOTE: after the installation of nvim
  # fix for <C-h> not working well within nvim
  # see https://github.com/christoomey/vim-tmux-navigator/issues/61#issuecomment-87284887
  #
  #   infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti && tic $TERM.ti && rm $TERM.ti
  #
}

main $@

