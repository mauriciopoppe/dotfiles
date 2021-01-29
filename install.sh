#!/bin/bash
export DOTFILES_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
    # the file exists but it doesn't have the dotfiles env var
    echo "export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" >> $ZENV
  else
    # the file exists but we need to update the env var
    sed -e "s%export DOTFILES_DIRECTORY=.*$%export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}%" $ZENV
  fi
fi

# temporarily add ./zsh/bin to $PATH
export PATH=$PATH:"${DOTFILES_DIRECTORY}/zsh/bin"

# now dotfiles is ready!
#
#       $ dotfiles
#
cat << EOF

Summary of operations

- Line "exports \$DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" added to ~/.zshenv
- Added ${DOTFILES_DIRECTORY}/zsh/bin to \$PATH (for the current process)

          $ dotfiles --help

EOF
