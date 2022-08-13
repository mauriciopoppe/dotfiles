#!/bin/bash

theme=dark

if [ -f ~/.tmux.theme ]; then
    theme=$(cat ~/.tmux.theme)
fi

tmux source-file ${DOTFILES_DIRECTORY}/tmux/theme.${theme}.conf
