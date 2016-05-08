# !/bin/zsh
# osx
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias showhiddenfiles='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidehiddenfiles='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'

# utilities
alias path='echo -e ${PATH//:/\\n}'
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias search='ag -i $1'
alias reload='. ~/.zshrc'
alias http-server='live-server'

# shortcuts and remaps
alias c='clear'
alias l.='ls -d .*'
alias sha1='openssl sha1'
alias mkdir='mkdir -pv'
alias catc='pygmentize -g'

# tmux aliases
# also check out `./functions` to switch/kill sessions
alias ta='tmux attach -t'
alias td='tmux detach'
alias tns='tmux new-session -s'

