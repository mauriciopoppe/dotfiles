#!/bin/zsh

local base=${0:h}

main() {
  print-header "git"

  print-step "git symlinks..."
  symlink "${base}/gitignore" "${HOME}/.gitignore"
  symlink "${base}/gitconfig" "${HOME}/.gitconfig"
  symlink "${base}/lazygit-config.yml" "${XDG_CONFIG_HOME}/lazygit/config.yml"

  print-message "remember to update the contents of secret/gitconfig.mine and secret/gitconfig.work"
}

main $@

