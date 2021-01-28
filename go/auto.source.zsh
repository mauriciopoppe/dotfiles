# export GOROOT=/usr/local/opt/go/libexec
# https://golang.org/doc/code.html
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

if [ -f "$HOME/.gvm/scripts/gvm" ]; then . "$HOME/.gvm/scripts/gvm"; fi
