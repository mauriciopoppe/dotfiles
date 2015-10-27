#!/bin/zsh

echo "installing antigen..."
if ! [[ -d ~/antigen ]] then
	git clone https://github.com/zsh-users/antigen.git ~/antigen
fi

