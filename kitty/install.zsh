#!/bin/zsh

local base=${0:h}

main() {
  print-header "kitty"

  symlink "${base}/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
}

main $@

