#!/bin/zsh

echo "installing homebrew..."
if ! type "brew" > /dev/null; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# see http://sourabhbajaj.com/mac-setup/Homebrew/Cask.html
echo "installing homebrew packages..."
# cli tools
brew install tree ack wget

# vim + tmux ftw
brew install macvim --override-system-vim
brew install tmux
brew install reattach-to-user-namespace
brew install python ruby node
brew install the_silver_searcher # ag

# apps
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew cask install qlstephen qlmarkdown
brew cask install iterm2

