#!/bin/zsh
# awesome dotfiles from
# - https://github.com/shawncplus/dotfiles
# - https://github.com/nicknisi/dotfiles
INSTALLDIR=${1:-$HOME}

echo "symlinking dotfiles..."
for i in .zshrc .zsh .vimrc .vim .tmux.conf .tmux .gitconfig bin; do
  # .old cleanup
	if [[ -e $INSTALLDIR/$i.old ]] then
    rm -r $INSTALLDIR/$i.old
  fi
	mv $INSTALLDIR/$i $INSTALLDIR/$i.old
	ln -s $PWD/$i $INSTALLDIR
done

source install/antigen.zsh
source install/vundle.zsh
source install/brew.zsh
source install/tpm.zsh

echo "installing vim plugins..."
vim +PluginInstall +qall

source ~/.zshrc

echo "done!"
