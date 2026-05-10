#!/bin/zsh

local base=${0:h}

main() {
  print-header "cmux"

  print-step "cmux symlinks..."
  symlink "${base}/cmux.json" "${HOME}/.config/cmux/cmux.json"
}

main $@
