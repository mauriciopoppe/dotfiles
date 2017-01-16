#!/bin/zsh
# force $PATH to have unique values
# typeset -U path
# fix path
# - /usr/local/bin should be first (brew)
path=(/usr/local/bin "$path[@]")
path+=(
  # path to my scripts
  ${DOTFILES_DIRECTORY}/bin
  ${DOTFILES_DIRECTORY}/bin/private
  /Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin
  /Users/mauricio/bin/Sencha/Cmd/3.1.2.342
  /Users/mauricio/bin/Sencha/Cmd/6.2.0.103
  $HOME/.yarn/bin
)
export PATH

# neovim
export VISUAL=nvim

# default editor
export EDITOR="$VISUAL"

# `fzf` default stdin command
# --hidden: include hidden files in the search
export FZF_DEFAULT_COMMAND='ag --smart-case --hidden --ignore .git --ignore .svn --ignore node_modules --ignore .idea --follow -g ""'
export FZF_DEFAULT_OPTS='--reverse --inline-info --cycle --algo=v1'

# vim: syn=zsh
