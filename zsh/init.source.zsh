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

# kubernetes dev setup
# https://github.com/kubernetes/community/blob/master/contributors/devel/development.md
# I generated the following exports with this command
#
# GNUBINS="$(find /usr/local/opt -type d -follow -name gnubin -print)"
# for bindir in ${GNUBINS[@]}
# do
#   echo $bindir
# done
# export PATH
#
GNUBINS=(
  # /usr/local/opt/coreutils/libexec/gnubin
  # /usr/local/opt/gnu-tar/libexec/gnubin
  # /usr/local/opt/ed/libexec/gnubin
  # /usr/local/opt/grep/libexec/gnubin
  # /usr/local/opt/gnu-sed/libexec/gnubin
  # /usr/local/opt/gsed/libexec/gnubin
  # /usr/local/opt/gawk/libexec/gnubin
  # /usr/local/opt/make/libexec/gnubin
  # /usr/local/opt/findutils/libexec/gnubin
)
for gnubindir in $GNUBINS[@]
do
  export PATH=$gnubindir:$PATH
done

###############################################################################
# functions
###############################################################################

# use ag when indexing
_fzf_compgen_path() {
  ag -g "" "$1"
}

competitive() {
  g++ -std=c++17 -Wshadow -Wall $1 -O2 -Wno-unused-result && ./a.out
}

competitive_boost() {
  now=$(date +"%Y_%m_%d__%H_%M_%S")
  FILENAME=${TMPDIR}$(basename "$1")"__"${now}
  g++ -std=c++11 -pedantic -lboost_system -Wextra -Wall -Wno-sign-compare -O2 -fsanitize=undefined $1 -o $FILENAME && $FILENAME
}

# terraform switch
tfnew() {
  tgenv use 0.23.17
  tfenv use 0.12.24
}

tfold() {
  tgenv use 0.18.3
  tfenv use 0.11.14
}
