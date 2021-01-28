# safe-source ${HOME}/.rvm/scripts/rvm
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi
