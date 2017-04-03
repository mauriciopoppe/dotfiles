#!/bin/zsh

formula-exists() {
  if ! command-exists "brew"; then
    print-error "make sure that 'brew' is installed"
  else
    brew list $1 > /dev/null
  fi
}

cask-exists() {
  if ! command-exists "brew"; then
    print-error "make sure that 'brew' is installed"
  else
    brew cask list $1 > /dev/null
  fi
}

