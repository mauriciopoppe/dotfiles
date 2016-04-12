#!/bin/zsh
# force $PATH to have unique values
# typeset -U path
# fix path
# - /usr/local/bin should be first (brew)
path=(/usr/local/bin "$path[@]")
path+=(
  # path to my scripts
  ${DOTFILES_DIRECTORY}/bin
  /Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin
)
export PATH

# neovim
export VISUAL=nvim

# default editor
export EDITOR="$VISUAL"

# `fzf` default stdin command
export FZF_DEFAULT_COMMAND='ag -g ""'

# vim: syn=zsh
