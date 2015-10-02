# http://unix.stackexchange.com/questions/62579/is-there-a-way-to-add-a-directory-to-my-path-in-zsh-only-if-its-not-already-pre
# force $PATH to have unique values
# typeset -U path

path=(/usr/local/bin "$path[@]")

path+=( 
  ~/bin
)

