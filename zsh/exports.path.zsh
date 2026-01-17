#!/bin/zsh
# vim: syn=zsh

# force $PATH to have unique values
typeset -U path
path=(
  # https://github.com/Homebrew/discussions/discussions/417#discussioncomment-326469
  # homebrew start
  /opt/homebrew/bin
  # homebrew end
  ~/.local/bin
  /usr/local/bin
  /usr/local/sbin
  # flutter start
  ~/development/flutter/bin
  ~/.pub-cache/bin
  # flutter end
  # gem start
  ~/.gem/bin
  # gem end
  # bun start, the all in one JavaScript runtime
  ~/.bun/bin
  # krew, the kubernetes plugin manager
  # n start
  ~/n/bin
  # n end
  ${KREW_ROOT:-$HOME/.krew}/bin
  # .dotfiles exports
  ${DOTFILES_DIRECTORY}/zsh/bin
  ${DOTFILES_DIRECTORY}/secret
  ${DOTFILES_DIRECTORY_ALT}/secret

  "$path[@]"
)
export PATH

# editor
if [[ "$HOST" == "DietPi" ]] || [[ "$HOST" == "orangepi" ]]; then
  export VISUAL=vim
else
  export VISUAL=nvim
fi
export EDITOR="$VISUAL"

export HISTCONTROL=ignorespace

# `fzf` default stdin command
#
# --files: List files that would be searched but do not search
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# --hidden: include hidden files in the search
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# check the colors in neovim/lua/my/config/init.lua
# default colors are for the dark mode, I entered the values to https://minsw.github.io/fzf-color-picker/
fzf_color='
 --color=fg:#ffffff,bg:#2a2c33,hl:#8abdb6
 --color=fg+:#8abdb6,bg+:#424f58,hl+:#5fd7ff
 --color=info:#afaf87,prompt:#d7005f,pointer:#8abdb6
 --color=marker:#87ff00,spinner:#8abdb6,header:#87afaf'
if [[ -f ~/.theme ]] && [[ $(cat ~/.theme) == *light* ]]; then
  fzf_color='
 --color=fg:#1d2025,bg:#ffffff,hl:#424f58
 --color=fg+:#1d2025,bg+:#e8eaef,hl+:#424f58
 --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
 --color=marker:#87ff00,spinner:#af5fff,header:#8abdb6'
fi
export FZF_DEFAULT_OPTS="--reverse $fzf_color --inline-info --cycle"

export GPG_TTY=$(tty)
export GITHUB_USER=mauriciopoppe

# git fuzzy
export GF_GREP_COLOR='1;30;48;5;15'

# use a development build of go if gotip is available
# if command -v gotip > /dev/null; then
#   export export PATH="$(gotip env GOROOT)/bin:$PATH"
# fi
