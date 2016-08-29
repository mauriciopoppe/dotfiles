#!/bin/bash

DOTFILES_REMOTE="maurizzzio/dotfiles"
export DOTFILES_DIRECTORY="${HOME}/.dotfiles"

# cloning the remote repo if ${DOTFILES_DIRECTORY} isn't a git repo
if [[ ! -d ${DOTFILES_DIRECTORY}/.git ]]; then
  echo "dotfiles copy not found, cloning from remote"
  git clone "https://github.com/${DOTFILES_REMOTE}" "${DOTFILES_DIRECTORY}"
  source ${DOTFILES_DIRECTORY}/install.sh
  return
fi

# DOTFILES_DIRECTORY must persist upon restart
# executing './install.sh' won't save it since it's a script that is 
# running as a child process
#
# The solution is to add an ENV var called ${DOTFILES_DIRECTORY} to .zshenv
# see http://zsh.sourceforge.net/Intro/intro_3.html
ZENV=$HOME/.zshenv
if [[ ! -f $ZENV ]]; then
  echo "export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" > $ZENV
else 
  if [[ -z $(cat $ZENV | grep DOTFILES_DIRECTORY) ]]; then
    # the file exists but it doesn't have the dotfiles dir
    echo "export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" >> $ZENV
  else
    # the file exists but it's value needs to be updated
    sed -e "s%export DOTFILES_DIRECTORY=.*$%export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}%" $ZENV
  fi
fi

# temporarily add ./bin to $PATH 
export PATH=$PATH:"${DOTFILES_DIRECTORY}/bin"

# now dotfiles is ready!
#       
#       $ dotfiles
#
cat << EOF

#      _       _    __ _ _
#   __| | ___ | |_ / _(_) | ___  ___
#  / _  |/ _ \\| __| |_| | |/ _ \\/ __|
# | (_| | (_) | |_|  _| | |  __/\\__ \\
#  \\__,_|\\___/ \\__|_| |_|_|\\___||___/
#

Summary of operations

- Dotfiles repository cloned to ${DOTFILES_DIRECTORY}
- Line "exports \$DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" added to ~/.zshenv
- Added ${DOTFILES_DIRECTORY}/bin to \$PATH (for the current process)

Note: nothing was changed/installed yet, you need to interact with the dotfiles binary

          $ dotfiles --help

EOF
