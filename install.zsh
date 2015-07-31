#!/bin/zsh
# awesome dotfiles from https://github.com/shawncplus/dotfiles/blob/master/install
INSTALLDIR=${1:-$HOME}

echo -e "\nsymlinking dotfiles..."
for i in .zshrc .vimrc .vim .gitconfig bin antigen; do
	mv $INSTALLDIR/$i $INSTALLDIR/$i.old 2> /dev/null
	ln -s $PWD/$i $INSTALLDIR/$i;
done

# some symlinks to know programs
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# install git submodules
echo -e "\nInitializing submodules..."
git submodule init && git submodule update