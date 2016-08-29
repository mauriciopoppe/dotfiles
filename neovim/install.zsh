#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

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

  print-step "setting up directories..."
  mkdir -p ${HOME}/.config/nvim/{autoload,sessions,undo,plugged} 2> /dev/null

  print-step "installing neovim..."
  if ! formula-exists neovim; then
    brew install neovim/neovim/neovim
  else
    print-message "neovim already installed"
  fi

  print-step "installing neovim python package..."
  pip install neovim

  print-step "installing vim-plug..."
  -install-vim-plug ${HOME}/.config/nvim/autoload/plug.vim

  print-step "neovim symlinks..."

  # if the whole `neovim` folder is symlinked to `~/.config/nvim` then
  # all the metadata created by neovim will also be shown as files of the 
  # project
  #
  # To avoid this unwanted behavior just sync some files/folders
  #
  symlink "${base}/init.vim" "${HOME}/.config/nvim/init.vim"
  symlink "${base}/autoload/utils.vim" "${HOME}/.config/nvim/autoload/utils.vim"
  symlink "${base}/UltiSnips" "${HOME}/.config/nvim/UltiSnips"
  symlink "${base}/spell" "${HOME}/.config/nvim/spell"
  symlink "${base}/config" "${HOME}/.config/nvim/config"

  print-step "installing plugins..."
  nvim +PlugInstall +qall

  # NOTE: after the installation of nvim
  # fix for <C-h> not working well within nvim
  # see https://github.com/christoomey/vim-tmux-navigator/issues/61#issuecomment-87284887
  #
  #   infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti && tic $TERM.ti && rm $TERM.ti
  #
}

main $@

