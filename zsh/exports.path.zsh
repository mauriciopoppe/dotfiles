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
  # needed to build kubernetes in macos
  /opt/homebrew/opt/libtool/libexec/gnubin
  /opt/homebrew/opt/coreutils/libexec/gnubin
  /opt/homebrew/opt/gnu-tar/libexec/gnubin
  /opt/homebrew/opt/ed/libexec/gnubin
  /opt/homebrew/opt/grep/libexec/gnubin
  /opt/homebrew/opt/gnu-sed/libexec/gnubin
  /opt/homebrew/opt/gsed/libexec/gnubin
  /opt/homebrew/opt/gawk/libexec/gnubin
  /opt/homebrew/opt/make/libexec/gnubin
  /opt/homebrew/opt/findutils/libexec/gnubin
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
export FZF_DEFAULT_OPTS='--reverse --color=dark --inline-info --cycle'

export GPG_TTY=$(tty)
export GITHUB_USER=mauriciopoppe

# git fuzzy
export GF_GREP_COLOR='1;30;48;5;15'

# use a development build of go if gotip is available
if command -v gotip > /dev/null; then
  export export PATH="$(gotip env GOROOT)/bin:$PATH"
fi
