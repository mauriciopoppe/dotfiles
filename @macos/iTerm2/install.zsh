#!/bin/zsh

[ "$(uname -s)" != "Darwin" ] && exit 0

defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "$DOTFILES_DIRECTORY/@macos/iTerm2"
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

