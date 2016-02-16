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
  # this is done so that only these folders are synced
  symlink "${base}/init.vim" "${HOME}/.config/nvim/init.vim"
  symlink "${base}/autoload/utils.vim" "${HOME}/.config/nvim/autoload/utils.vim"
  symlink "${base}/UltiSnips" "${HOME}/.config/nvim/UltiSnips"
  symlink "${base}/spell" "${HOME}/.config/nvim/spell"

  print-step "installing plugins..."
  nvim +PlugInstall +qall

  # NOTE: first time installation
  # fix <C-h> not working well within nvim
  # see https://github.com/christoomey/vim-tmux-navigator/issues/61#issuecomment-87284887
}

main $@

