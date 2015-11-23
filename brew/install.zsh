#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "brew formulas"

  print-step "updating brew..."

  brew update

  print-step "installing formulas..."

  brew install tree
  brew install youtube-dl
  brew install the_silver_searcher
}

main $@

