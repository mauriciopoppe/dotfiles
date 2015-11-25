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
  brew install fasd
  # terminal gifs (it's kinda slow)
  brew install imagemagick ttyrec
  brew install https://raw.githubusercontent.com/icholy/ttygif/master/ttygif.rb
}

main $@

