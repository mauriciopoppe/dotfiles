# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fasd (https://github.com/clvv/fasd)
fasd_cache="${HOME}/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# the fuck (https://github.com/nvbn/thefuck)
eval $(thefuck --alias)

# kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl/#using-zsh)
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

###############################################################################
# functions
###############################################################################

# use ag when indexing
_fzf_compgen_path() {
  ag -g "" "$1"
}

competitive() {
  now=$(date +"%Y_%m_%d__%H_%M_%S")
  FILENAME=${TMPDIR}$(basename "$1")"__"${now}
  g++ -std=c++11 -pedantic -Wextra -Wall -Wno-sign-compare -O2 -fsanitize=undefined $1 -o $FILENAME && $FILENAME
}
