#!/bin/zsh

local base=${0:h}

main() {
  print-header "tmux"

  print-step "setting up directories..."
  mkdir -p ${HOME}/.tmux/plugins 2> /dev/null

  print-step "installing tmux..."
  if ! formula-exists "tmux"; then
    brew install tmux
  else
    print-message "tmux already installed"
  fi

  print-step "installing tmux plugin manager..."
  if [[ ! -d ${HOME}/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
  else
    print-message "tpm already installed"
  fi

  print-step "tmux symlinks..."
  symlink "${base}/.tmux.conf" "${HOME}/.tmux.conf"

  print-step "installing plugins..."
  ${HOME}/.tmux/plugins/tpm/bin/install_plugins > /dev/null

  print-step "complete!"
}

main $@

