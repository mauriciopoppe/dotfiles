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
    sudo apt-get install python3 pip python3-venv
  fi

  print-step "installing python modules..."
  local modules
  modules=(
    grip              # preview markdown files
    virtualenv        # local dependency management
    jedi              # autocomplete
    yapf              # formatter
    ruff              # linter
    ruff-lsp          # lsp support
    jupyter           # jupyter notebooks
  )
  pip3 install ${modules[@]}
}

main $@

