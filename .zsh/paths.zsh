export PATH=$PATH:~/bin

# OS X Aliases
if [[ $CURRENT_OS == 'OS X' ]]; then
  # Prefix /usr/local/bin for brew
  export PATH=/usr/local/bin:$PATH
fi	