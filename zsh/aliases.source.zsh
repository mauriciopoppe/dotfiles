# !/bin/sh

# day to day shortcuts
alias c='clear'
alias l.='ls -dahG .*'
alias la='ls -lahG'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# utilities
alias path='echo -e ${PATH//:/\\n}'
alias publicip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | perl -nle '/(\d+\.\d+\.\d+\.\d+)/ && print \$1'"
alias search='ag -i $1'
alias reload='. ~/.zshrc'
alias http-server='live-server'
alias catc='pygmentize -g'
alias sha1='openssl sha1'
alias npmoffline='npm --cache-min 9999999 '

# remaps
alias grep='grep --color'
if hash ccat 2> /dev/null; then
  alias cat="ccat"
fi

# tmux aliases
# also check out `./functions` to switch/kill sessions
alias ta='tmux attach -t'
alias td='tmux detach'
alias tk='tmux kill-server'

