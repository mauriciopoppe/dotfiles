#!/bin/zsh

print-header() {
  printf "\n$(tput setaf 15)%s$(tput sgr0)\n\n" "$@"
}

print-step() {
  printf "$(tput setaf 15)  %s$(tput sgr0)\n" "$@"
}

print-message() {
  printf "$(tput setaf 5)    %s$(tput sgr0)\n" "$@"
}

print-success() {
  printf "$(tput setaf 64)Success: %s$(tput sgr0)%s\n" "$@"
}

print-error() {
  printf "$(tput setaf 1)Error: %s$(tput sgr0)%s\n" "$@"
}

print-warning() {
  printf "$(tput setaf 136)Warning: $(tput sgr0)%s\n" "$@"
}
