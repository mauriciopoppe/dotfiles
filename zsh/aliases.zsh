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
alias catc='pygmentize -g'
alias sha1='openssl sha1'

# aliases
alias c='clear'
alias l.='ls -d .*'
alias npmoffline='npm --cache-min 9999999 '

# remaps
alias mkdir='mkdir -pv'

# tmux aliases
# also check out `./functions` to switch/kill sessions
alias ta='tmux attach -t'
alias td='tmux detach'
alias tk='tmux kill-server'
# alias tns='tmux new-session -s'

