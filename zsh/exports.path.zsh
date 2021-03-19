#!/bin/zsh
# vim: syn=zsh

# force $PATH to have unique values
typeset -U path
# fix path
# - /usr/local/bin should be first (homebrew)
path=(
  /usr/local/bin
  /usr/local/sbin
  ~/.local/bin
  "$path[@]"
)
path+=(
  # path to my scripts
  ${DOTFILES_DIRECTORY}/zsh/bin
  ${DOTFILES_DIRECTORY}/secret
  ${DOTFILES_DIRECTORY_ALT}/secret
  ${KREW_ROOT:-$HOME/.krew}/bin
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
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--reverse --color=dark --inline-info --cycle'

export GPG_TTY=$(tty)

