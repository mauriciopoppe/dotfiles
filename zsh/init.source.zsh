# fzf (https://github.com/junegunn/fzf)
#
# The following line is commented because fzf checks with the following line
# on install
# __safe_source ${HOME}/.fzf.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fasd (https://github.com/clvv/fasd)
fasd_cache="${HOME}/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

###############################################################################
# functions
###############################################################################

# use ag when indexing
_fzf_compgen_path() {
  ag -g "" "$1"
}

