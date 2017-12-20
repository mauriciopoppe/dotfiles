#!/bin/zsh

main() {
  print-header "zsh"

  print-step "zsh symlinks..."
  symlink "$DOTFILES_DIRECTORY/zsh/.zshrc" "$HOME/.zshrc"

  print-step "complete!"
  restart-shell
}

main $@
