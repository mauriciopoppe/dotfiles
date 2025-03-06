#!/bin/zsh

local base=${0:h}

main() {
  print-header "lima"

  mkdir -p "${HOME}/.lima/debian"
  symlink "${base}/lima.yaml" "${HOME}/.lima/debian/lima.yaml"
}

main $@

