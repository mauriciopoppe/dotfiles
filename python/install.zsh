#!/bin/zsh

local cwd=${0:h}

main() {
  print-header "python"

  print-step "installing python 3..."

  if [[ $OSTYPE =~ ^darwin ]]; then
    brew install python3
    pip3 install --upgrade pip
  fi
  if [[ $OSTYPE =~ ^linux ]]; then
    sudo apt-get install python3 pip
  fi

  print-step "installing python modules..."
  local modules
  modules=(
    grip              # preview markdown files
    virtualenv        # local dependency management
    jedi              # autocomplete
    yapf              # formatter
    neovim            # neovim API
    flake8            # linter (actually a wrapper of pyflakes + other libs)
    ptpython          # better python repl
    howdoi            # get answers from google right into the CMD
    jupyter           # jupyter notebooks
  )
  pip3 install ${modules[@]}

  # configurations
  symlink "${cwd}/.ptpython/config.py" "${HOME}/.ptpython/config.py"
}

main $@

