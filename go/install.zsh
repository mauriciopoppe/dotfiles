#!/bin/zsh

main() {
  if command-exists go; then
    print-success "go is installed"
  else
    print-step "install go following the instructions in https://golang.org/doc/install"
  fi
}

main $@
