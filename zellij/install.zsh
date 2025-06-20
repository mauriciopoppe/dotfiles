#!/bin/zsh

local base=${0:h}

main() {
  print-header "zellij"

  mkdir -p ~/.config/zellij/plugins
  mkdir -p ~/.config/zellij/themes
  symlink "${base}/config.kdl" "${HOME}/.config/zellij/config.kdl"
  symlink "${base}/layouts" "${HOME}/.config/zellij/layouts"
  symlink "${base}/themes/my-theme-dark" "${HOME}/.config/zellij/themes/my-theme-dark"
  symlink "${base}/themes/my-theme-light" "${HOME}/.config/zellij/themes/my-theme-light"
  curl -LsSf https://github.com/fresh2dev/zellij-autolock/releases/download/0.2.2/zellij-autolock.wasm > ~/.config/zellij/plugins/zellij-autolock.wasm
}

main $@


