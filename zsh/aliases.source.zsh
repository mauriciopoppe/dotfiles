# !/bin/sh

# day to day shortcuts
alias c='clear'
alias ls='ls -G'
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
alias reload='. ~/.zshrc'
alias http-server='live-server'
alias catc='pygmentize -g'
alias sha1='openssl sha1'
alias npmoffline='npm --cache-min 9999999 '
alias help='tldr'

# remaps
alias grep='grep --color'
# if hash bat 2> /dev/null; then
#   alias cat="bat"
# fi

alias gt="lazygit"
alias pip="pip3"
alias python="python3"

# tmux aliases
alias ta='tmux attach -t'
alias td='tmux detach'

# k8s
alias kc='kubectl'
alias k='kubectl'

alias h='howdoi -ac'

# homebrew for x86_64 apps
alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias python3.7="/usr/local/opt/python@3.7/bin/python3.7"

# from https://blog.petdance.com/2020/02/03/handy-collection-of-shell-aliases/
alias paga='ps -u "$USER" f --header -o pid,ppid,start_time,%cpu,rssize=Resident,vsize=Virtual,cmd'

