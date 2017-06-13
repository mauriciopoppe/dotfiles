#!/bin/zsh
# vim: syn=zsh

# force $PATH to have unique values
typeset -U path
# fix path
# - /usr/local/bin should be first (homebrew)
path=(/usr/local/bin ~/.local/bin "$path[@]")
path+=(
  # path to my scripts
  ${DOTFILES_DIRECTORY}/bin
  ${DOTFILES_DIRECTORY}/bin/private
)
export PATH

# neovim
export VISUAL=nvim

# default editor
export EDITOR="$VISUAL"

# `fzf` default stdin command
#
# --files: List files that would be searched but do not search
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# --hidden: include hidden files in the search
export FZF_DEFAULT_COMMAND='ag --smart-case --hidden --ignore .git --ignore .svn --ignore node_modules --ignore .idea --follow -g ""'
export FZF_DEFAULT_OPTS='--reverse --color=dark --inline-info --cycle'
