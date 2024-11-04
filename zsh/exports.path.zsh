#!/bin/zsh
# vim: syn=zsh

# force $PATH to have unique values
typeset -U path
path=(
  # https://github.com/Homebrew/discussions/discussions/417#discussioncomment-326469
  # This is the homebrew path.
  /opt/homebrew/bin
  ~/.local/bin
  /usr/local/bin
  /usr/local/sbin
  # flutter start
  ~/development/flutter/bin
  ~/.pub-cache/bin
  # flutter end
  ~/.gem/bin
  "$path[@]"
  # bun, the all in one JavaScript runtime
  ~/.bun/bin
  # krew, the kubernetes plugin manager
  ${KREW_ROOT:-$HOME/.krew}/bin
  # .dotfiles exports
  ${DOTFILES_DIRECTORY}/zsh/bin
  ${DOTFILES_DIRECTORY}/secret
  ${DOTFILES_DIRECTORY_ALT}/secret
)
export PATH

# neovim
export VISUAL=nvim

# default editor
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
fzf_color="bg+:#3F3F3F,bg:#4B4B4B,border:#6B6B6B,spinner:#98BC99,hl:#719872,fg:#D9D9D9,header:#719872,info:#BDBB72,pointer:#E12672,marker:#E17899,fg+:#D9D9D9,preview-bg:#3F3F3F,prompt:#98BEDE,hl+:#98BC99"
if [[ -f ~/.tmux.theme ]] && [[ $(cat ~/.tmux.theme) == *light* ]]; then
  fzf_color="bg+:#D9D9D9,border:#C8C8C8,spinner:#719899,hl:#719872,fg:#616161,header:#719872,info:#727100,pointer:#E12672,marker:#E17899,fg+:#616161,preview-bg:#D9D9D9,prompt:#0099BD,hl+:#719899"
fi
export FZF_DEFAULT_OPTS="--reverse --color=${fzf_color} --inline-info --cycle"

export GPG_TTY=$(tty)
export GITHUB_USER=mauriciopoppe

# git fuzzy
export GF_GREP_COLOR='1;30;48;5;15'

# use a development build of go if gotip is available
# if command -v gotip > /dev/null; then
#   export export PATH="$(gotip env GOROOT)/bin:$PATH"
# fi
