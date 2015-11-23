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
  print-header "vim"

  print-step "setting up directories..."
  mkdir -p ${HOME}/.vim 2> /dev/null

  print-step "installing macvim..."
  if ! formula-exists macvim; then
    brew install macvim --with-cscope --with-lua --with-override-system-vim
  else
    print-message "macvim already installed"
  fi

  print-step "installing vim-plug..."
  -install-vim-plug ${HOME}/.vim/autoload/plug.vim

  print-step "vim symlinks..."
  symlink "${base}/vimrc" "${HOME}/.vimrc"

  print-step "installing plugins..."
  vim +PlugInstall +qall
}

main $@

