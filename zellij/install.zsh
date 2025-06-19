#!/bin/zsh

local base=${0:h}

main() {
  print-header "zellij"

  mkdir -p ~/.config/zellij/plugins
  symlink "${base}/config.kdl" "${HOME}/.config/zellij/config.kdl"
  symlink "${base}/layouts" "${HOME}/.config/zellij/layouts"
  symlink "${base}/themes" "${HOME}/.config/zellij/themes"
  curl -LsSf https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm > ~/.config/zellij/plugins/zellij-autolock.wasm
}

main $@


