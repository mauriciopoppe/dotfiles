#!/bin/zsh
# awesome dotfiles from https://github.com/shawncplus/dotfiles/blob/master/install
INSTALLDIR=${1:-$HOME}

echo "symlinking dotfiles..."
for i in .zshrc .zsh .vimrc .vim .gitconfig bin; do
	rm -r $INSTALLDIR/$i.old
	mv $INSTALLDIR/$i $INSTALLDIR/$i.old
	ln -s $PWD/$i $INSTALLDIR
done

echo "installing vim plugins..."
# additional vim plugins
# status bar in the lower section of the screen
for f in $INSTALLDIR/.vim/bundle/Vundle.vim; do 
	if ! [[ -e $f ]] then
		git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		git clone https://github.com/zsh-users/antigen.git ~/antigen
	fi
	break
done
brew install macvim --override-system-vim
brew install python ruby
pip install --user powerline-status
vim +PluginInstall +qall

echo "done!"