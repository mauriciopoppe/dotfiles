# osx
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias showhiddenfiles='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidehiddenfiles='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias finder='open -a Finder '

# git 
alias gst='git status'
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

# my blog runs in npm 0.10
alias blog='z blog-jekyll && make'

alias gcc='gcc-4.9'
alias cc='gcc-4.9'
alias g++='g++-4.9 -std=c++0x'
alias c++='c++-4.9'

# safe remove
alias rm='rm -i'

# npm
alias patch='pre-version && npm version patch && post-version'
alias minor='pre-version && npm version minor && post-version'
alias major='pre-version && npm version major && post-version'
alias pre-version='git diff --exit-code && npm prune && npm install -q && npm test'
alias post-version='npm run --if-present build && git diff --exit-code && git push && git push --tags && npm publish'

# alias to reload zsh
alias reload='echo "reloading zsh..." && source ~/.zshrc'

# utilities
alias path="echo $PATH | awk -v RS=: '1'"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
