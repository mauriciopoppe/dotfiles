#!/bin/zsh
# awesome dotfiles from https://github.com/shawncplus/dotfiles/blob/master/install
INSTALLDIR=${1:-$HOME}

echo "symlinking dotfiles..."
for i in .zshrc .zsh .vimrc .vim .gitconfig bin; do
	rm -r $INSTALLDIR/$i.old
	mv $INSTALLDIR/$i $INSTALLDIR/$i.old
	ln -s $PWD/$i $INSTALLDIR
done

echo "installing antigen..."
if ! [[ -d ~/antigen ]] then
	git clone https://github.com/zsh-users/antigen.git ~/antigen
fi

echo "installing vundle..."
if ! [[ -d ~/.vim/bundle/Vundle.vim ]] then
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "installing brew..."
if ! type "brew" > /dev/null; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# see http://sourabhbajaj.com/mac-setup/Homebrew/Cask.html
echo "installing apps..."
brew install macvim --override-system-vim
brew install python ruby
brew install the_silver_searcher

brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew cask install qlstephen qlmarkdown
brew cask install iterm2

echo "installing vim plugins..."
vim +PluginInstall +qall

source ~/.zshrc

echo "done!"
