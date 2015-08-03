source ~/antigen/antigen.zsh

# required for the theme
DEFAULT_USER=mauricio

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle dirhistory
antigen bundle node
antigen bundle npm
antigen bundle osx
antigen bundle zsh-users/zsh-syntax-highlighting

# node
antigen bundle node
antigen bundle rupa/z

# python
antigen bundle pip

# mine
antigen bundle $HOME/.zsh

# Theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply
