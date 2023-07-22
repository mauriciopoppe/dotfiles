#!/bin/zsh

local cwd=${0:h}

main() {
  print-header "ruby"
  print-step "installing ruby..."
  asdf plugin add ruby
  asdf install ruby 3.1.2
}

main $@

