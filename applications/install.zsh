#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "applications"

  print-step "updating brew..."

  brew update

  brew install caskroom/cask/brew-cask
  brew tap caskroom/versions
  brew tap caskroom/fonts

  print-step "installing apps..."

  # force the installation of casks to /Applications
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  # utilities
  brew cask install google-drive
  brew cask install spotify
  brew cask install flux
  brew cask install qlstephen qlmarkdown

  # development
  brew cask install iterm2 sublime-text3
}

main $@

