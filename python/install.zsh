#!/bin/zsh

local scriptcwd=${0:h}
source ${scriptcwd}/../lib/utils

main() {
  print-header "python"

  print-step "installing python 3..."
  brew install python3 --universal
  pip3 install --upgrade pip

  # npm global modules
  print-step "installing python modules..."

  local modules
  modules=(
    grip              # preview markdown files
    Pygments          # syntax highlighter
    virtualenv        # local dependency management
    jedi              # autocomplete
    yapf              # formatter
    flake8            # linter (actually a wrapper of pyflakes + other libs)
    ptpython          # better python repl
    howdoi            # get answers from google right into the CMD
  )
  for module in $modules; do
    # pip3 is already installed on python +3.4
    pip3 install $module
  done

  # configurations
  symlink "${scriptcwd}/.ptpython/config.py" "${HOME}/.ptpython/config.py"
}

main $@

