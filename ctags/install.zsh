#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "ctags"
  
  print-step "ctags symlinks..."
  symlink "${base}/ctags" "${HOME}/.ctags"
}

main $@

