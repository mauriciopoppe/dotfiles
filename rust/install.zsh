#!/bin/zsh

local base=${0:h}

main() {
  print-header "rust"

  print-step "installing rust..."
  if [[ $OSTYPE =~ ^darwin ]]; then
    if ! formula-exists rustup; then
      brew install rustup
    else
      print-message "rust already installed"
    fi
  fi

  # install rust & cargo
  rustup-init -y

  # relaunching shell
  # source ~/.zshrc

  # install cargo packages
  # modules=()
  # cargo install ${modules[@]}
}

main $@

