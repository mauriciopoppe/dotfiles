#!/bin/zsh
# vim: syn=zsh

# overrides the color of the * next to the branch name e.g. master*
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:dirty color 242
