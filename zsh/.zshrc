#!/bin/zsh
########
# init #
########

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chun

safe-source() {
  [[ -s $1 ]] && source $1
}

# fix colors when running tmux inside zsh
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# run nvim with italic comments
alias nvim="TERM=xterm-256color-italic nvim"

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#using-zsh
autoload -Uz compinit
compinit

#########
# zinit #
#########

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma/history-search-multi-word

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# BurntSushi/ripgrep
zinit ice as"command" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target.
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

#########################
# script initialization #
#########################

typeset -U CONFIG_FILES

source $DOTFILES_DIRECTORY/zsh/sensible.zsh

# (N) https://unix.stackexchange.com/questions/26805/how-to-silently-get-an-empty-string-from-a-glob-pattern-with-no-matches
CONFIG_FILES=($DOTFILES_DIRECTORY/*/*.zsh(N))
# ignore */install.zsh
CONFIG_FILES=(${CONFIG_FILES:#*/install.zsh})

# automatically initialize files that end in .path.zsh
DO_AUTO_SOURCE=(${(M)CONFIG_FILES:#*/*.path.zsh})
for file in $DO_AUTO_SOURCE; do
  source $file
done

# https://stackoverflow.com/questions/41872135/filtering-zsh-array-by-wildcard
# automatically initialize files that end in .source.zsh
DO_AUTO_SOURCE=(${(M)CONFIG_FILES:#*/*.source.zsh})
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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

GCSDK=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
if [ -f "$GCSDK/path.zsh.inc" ]; then . "$GCSDK/path.zsh.inc"; fi
if [ -f "$GCSDK/completion.zsh.inc" ]; then . "$GCSDK/completion.zsh.inc"; fi
