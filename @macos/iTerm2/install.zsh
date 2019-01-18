#!/bin/zsh

echo "Installing iTerm2"

ROOT=$DOTFILES_DIRECTORY/@macos/iTerm2
CONFIG_DIR="$ROOT/config"
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string $CONFIG_DIR
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

# copy plist file in config dir if it doesn't exist
if [[ ! -f $CONFIG_DIR ]]; then
  echo "creating iTerm config directory"
  mkdir -p $CONFIG_DIR

  echo "copying default configuration file"
  cp $ROOT/com.googlecode.iterm2.plist $CONFIG_DIR
fi
