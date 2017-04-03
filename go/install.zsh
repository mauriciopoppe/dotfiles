#!/bin/zsh

main() {

  print-header "go"

  print-step "installing go..."
  if [[ is-macos ]]; then

    if ! command-exists "go"; then
      brew install go
    fi

    print-step "modifying zshrc paths"
    add-unique-line-to-file \
      "source $DOTFILES_DIRECTORY/go/go-zshrc" \
      $DOTFILES_DIRECTORY/zsh/exports.zsh

    restart-shell
  fi


}

main $@
