#!/bin/zsh

########
# init #
########

safe-source() {
  [[ -s $1 ]] && source $1
}

# fix colors when running tmux inside zsh
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# run nvim with italic comments
alias nvim="TERM=xterm-256color-italic nvim"

#########
# zplug #
#########

# Check if zplug is installed
export ZPLUG_HOME=~/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

# lock at the latest stable version
(cd $ZPLUG_HOME && git checkout tags/2.4.1) > /dev/null 2>&1 || exit 1
source $ZPLUG_HOME/init.zsh

# NOTE: $DOTFILES_DIRECTORY is defined in .zshenv
zplug "$DOTFILES_DIRECTORY/zsh/plugins/zsh-sensible", from:local
zplug "$DOTFILES_DIRECTORY/zsh/plugins/bookmark", \
  as:command, \
  hook-build:"chmod +x bin/*", \
  use:"bin/*", \
  from:local

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"
zplug "djui/alias-tips"
zplug "b4b4r07/enhancd", use:enhancd.sh

# zplug "plugins/dirhistory", from:"oh-my-zsh"
# zplug "plugins/git", from:"oh-my-zsh"
zplug "plugins/osx", from:"oh-my-zsh"
zplug "bobthecow/git-flow-completion", from:github

# prompt
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

#########################
# script initialization #
#########################

typeset -U CONFIG_FILES
# (N) https://unix.stackexchange.com/questions/26805/how-to-silently-get-an-empty-string-from-a-glob-pattern-with-no-matches
CONFIG_FILES=($DOTFILES_DIRECTORY/*/*.zsh(N))
# ignore */install.zsh
CONFIG_FILES=(${CONFIG_FILES:#*/install.zsh})

# automatically initialize files that end in .path.zsh
DO_AUTO_SOURCE=(${CONFIG_FILES:#*/*.path.zsh})
for file in $DO_AUTO_SOURCE; do
  source $file
done

# automatically initialize files that end in .source.zsh
DO_AUTO_SOURCE=(${CONFIG_FILES:#*/*.source.zsh})
for file in $DO_AUTO_SOURCE; do
  source $file
done

# local configuration
safe-source ${HOME}/.localrc

# remove functions from the global scope
unset -f safe-source

####################
# sourced manually #
####################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/mpoppe1/n/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/mpoppe1/n/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/mpoppe1/n/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/mpoppe1/n/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh