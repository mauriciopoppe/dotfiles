#!/bin/zsh

# use ag when indexing
_fzf_compgen_path() {
  ag -g "" "$1"
}

# vim: set ft=zsh
