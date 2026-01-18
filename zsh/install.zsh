#!/bin/zsh

main() {
  print-header "zsh"

  print-step "zsh symlinks..."
  symlink "$DOTFILES_DIRECTORY/zsh/.zshrc" "$HOME/.zshrc"
  symlink "$DOTFILES_DIRECTORY/zsh/p10k.zsh" "$HOME/.p10k.zsh"

  print-step "complete!"
  restart-shell
}

main $@
