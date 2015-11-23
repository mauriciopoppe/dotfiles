#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "python"

  print-step "installing python..."
  brew install python

  # npm global modules
  print-step "installing python modules..."

  local modules
  modules=(
    grip              # preview markdown files
  )
  for module in $modules; do
    # pip is already installed on python +3.4
    pip install grip
  done
}

main $@

