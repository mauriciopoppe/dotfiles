#!/bin/zsh

set -e

local base=${0:h}

main() {
  print-header "mpv"

  symlink "${base}/mpv.conf" "${HOME}/.config/mpv/mpv.conf"
  symlink "${base}/input.conf" "${HOME}/.config/mpv/input.conf"
  symlink "${base}/scripts" "${HOME}/.config/mpv/scripts"
}

main $@
