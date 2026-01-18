#!/bin/zsh

local cwd=${0:h}

main() {
  print-header "python"

  print-step "installing python 3..."

  if is-macos; then
    brew install python3
    pip3 install --upgrade pip
  fi
  if [[ $OSTYPE =~ ^linux ]]; then
    sudo apt-get install python3 pip python3-venv
  fi
  if ! type uv >> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
  fi

  print-step "Global modules aren't installed, to run a tool use: uvx <tool>"
  # local modules
  # modules=(
  #   grip              # preview markdown files
  #   jedi              # autocomplete
  #   ruff              # linter
  #   ruff-lsp          # lsp support
  #   jupyter           # jupyter notebooks
  # )
}

main $@

