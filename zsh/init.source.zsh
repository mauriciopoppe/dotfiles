# fasd (https://github.com/clvv/fasd)
fasd_cache="${HOME}/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl/#using-zsh)
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# helm completion
if [ $commands[helm] ]; then
  source <(helm completion zsh | sed -E 's/\["(.+)"\]/\[\1\]/g')
fi

###############################################################################
# functions
###############################################################################

competitive() {
  g++ -std=c++17 -Wshadow -Wall $1 -O2 -Wno-unused-result && ./a.out
}

competitive_boost() {
  now=$(date +"%Y_%m_%d__%H_%M_%S")
  FILENAME=${TMPDIR}$(basename "$1")"__"${now}
  g++ -std=c++11 -pedantic -lboost_system -Wextra -Wall -Wno-sign-compare -O2 -fsanitize=undefined $1 -o $FILENAME && $FILENAME
}

