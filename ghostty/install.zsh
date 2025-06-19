#!/bin/zsh

local base=${0:h}

main() {
  print-header "kitty"

  symlink "${base}/ghostty.conf" "${HOME}/.config/ghostty/config"
}

main $@

