#!/bin/zsh

local cwd=${0:h}

main() {
  print-header "ruby"
  print-step "installing ruby..."
  
  if command-exists rbenv; then
    # check if version is already installed
    if ! rbenv versions | grep "3.1.2" > /dev/null; then
      rbenv install 3.1.2
    else
      print-message "ruby 3.1.2 already installed"
    fi
    rbenv global 3.1.2
  else
    print-error "rbenv not found"
  fi
}

main $@

