# !/bin/sh

# day to day shortcuts
alias c='clear'
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
alias pip="pip3"
alias python="python3"
if hash eza 2> /dev/null; then
  alias ls="eza"
fi

# k8s
alias k='kubectl'

alias h='howdoi -ac'

# homebrew for x86_64 apps
alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias python3.7="/usr/local/opt/python@3.7/bin/python3.7"

# from https://blog.petdance.com/2020/02/03/handy-collection-of-shell-aliases/
alias paga='ps -u "$USER" f --header -o pid,ppid,start_time,%cpu,rssize=Resident,vsize=Virtual,cmd'

