#!/bin/zsh

echo "installing tmux plugin manager..."
if ! [[ -d ~/.tmux/plugins ]] then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

