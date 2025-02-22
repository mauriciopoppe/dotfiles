#!/bin/bash

# This shell script is run when .tmux.conf is loaded.
# See .tmux.conf for details.

theme=dark
if [ -f ~/.tmux.theme ]; then
    theme=$(cat ~/.tmux.theme)
fi

tmux source-file ${DOTFILES_DIRECTORY}/tmux/theme.${theme}.conf
