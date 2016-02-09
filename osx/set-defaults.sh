#!/bin/sh
#
# OSX defaults
#
# Original idea: https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Show the ~/Library folder.
chflags nohidden ~/Library

# Finder
# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Allow text selection in the Quick Look window
defaults write com.apple.finder QLEnableTextSelection -bool true

# Dock
# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Others
# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Disable Photos.app from starting everytime a device is plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# Disable menubar transparency
defaults write com.apple.universalaccess reduceTransparency -bool true
# Show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool true

