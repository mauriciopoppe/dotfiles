#!/bin/zsh

echo "installing vundle..."
if ! [[ -d ~/.vim/bundle/vundle.vim ]] then
	git clone https://github.com/gmarik/vundle.vim.git ~/.vim/bundle/vundle.vim
fi

