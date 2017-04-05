#!/bin/zsh
# vim: syn=zsh

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

# sencha env vars
export SENCHA_CMD_3='/Users/mauricio/bin/Sencha/Cmd/3.1.2.342'
export SENCHA_CMD_4='/Users/mauricio/bin/Sencha/Cmd/4.0.5.87'
export SENCHA_CMD_6='/Users/mauricio/bin/Sencha/Cmd/6.2.1.29'

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

# TODO: pull ignores as an array and set a global $IGNORE
export FZF_DEFAULT_COMMAND='rg --files --smart-case --hidden --follow \
  --glob "!.git" \
  --glob "!.idea" \
  --glob "!.svn" \
  --glob "!node_modules/" \
  --glob "!__pycache__" \
  --glob "!venv/"'
export FZF_DEFAULT_OPTS='--reverse --color=dark --inline-info --cycle'
