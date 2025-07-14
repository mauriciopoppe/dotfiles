# man zshoptions

########################
# changing directories #
########################

# push old dir onto the dir stack
setopt auto_pushd

##############
# completion #
##############

# enable menu completion on second consecutive request for completion (tab * 2)
setopt automenu

###########
# history #
###########

# history sane defaults
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
# zsh sessions will append history list to the history file, rather than replace it
setopt append_history
# save timestamp and the duration to the history file
setopt extended_history
# If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
setopt hist_ignore_all_dups
# ignore commands that start with space
setopt hist_ignore_space
# perform history expansion first
setopt hist_verify
# append history lines incrementally rather than waiting for the shell to exit
setopt inc_append_history
# import/export history lines to the current zsh session
setopt share_history

################
# input/output #
################

# try to correct the spelling of commands
setopt correct
# wait ten second to execute a `rm *` command
setopt rm_star_wait

###############################
# zsh line editing mode (zle) #
###############################

# bindkey -v

# <C-x><C-e> Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# remove command+l binding to delete a line
bindkey -r "^L"

# forward-delete char on osx with fn + delete
bindkey "^[[3~" delete-char

# move between words with alt + <-, alt + ->
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# ^u clears the line before executing the command.
# ctrl+e = nvim
bindkey -s "^e" "^unvim\n"
# ctrl+g = git
bindkey -s "^g" "^ulazygit\n"
