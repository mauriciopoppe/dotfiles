#!/bin/zsh

# export the dotfiles directory
export DOTFILES_DIRECTORY=${0:a:h}

local DOTFILES_REMOTE="maurizzzio/dotfiles"

# cloning the remote repo if ${DOTFILES_DIRECTORY} isn't a git repo
if [[ ! -d ${DOTFILES_DIRECTORY}/.git ]]; then
  local DOTFILES_LOCAL="${1:-${HOME}/.dotfiles}"
  # change this line to your repo!
  git clone "https://github.com/${DOTFILES_REMOTE}" "${DOTFILES_LOCAL}"
  zsh -c "source ${DOTFILES_LOCAL}/install.zsh"
  # exit with the exit code of calling itself on the repo
  exit $?
fi

# DOTFILES_DIRECTORY must persist upon restart
# executing './install.sh' won't save it since it's a script that is 
# running as a child process
#
# The solution is to source ${HOME}/.envvars.rc on restart
if [[ ! -f ${HOME}/.envvars.rc ]]; then
  echo "export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" > ${HOME}/.envvars.rc
else 
  if [[ $(cat ${HOME}/.envvars.rc | grep DOTFILES_DIRECTORY) ]]; then
    # the file exists but it doesn't have the dotfiles dir
    echo "export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}" >> ${HOME}/.envvars.rc
  else
    # the file exists but it's value needs to be updated
    sed -i ${HOME}/.envvars.rc -e "s/export\sDOTFILES_DIRECTORY=.*$/export DOTFILES_DIRECTORY=${DOTFILES_DIRECTORY}/"
  fi
fi

# temporarily add ./bin to $PATH 
path+=(${DOTFILES_DIRECTORY}/bin)
export PATH

# now dotfiles is ready!
#       
#       $ dotfiles
#
cat << EOF

# dotfiles installation

Summary of operations

- Dotfiles repository cloned to ${DOTFILES_DIRECTORY}
- Added ${DOTFILES_DIRECTORY}/bin to \$PATH

Note: nothing was changed yet, you need to interact with the dotfiles binary :)

          $ dotfiles --help

EOF
