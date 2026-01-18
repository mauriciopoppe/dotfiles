#!/bin/zsh
autoload is-at-least

command-exists() {
  type $1 > /dev/null
}

is-macos() {
  [[ $OSTYPE =~ ^darwin ]] || return 1
}

is-pi() {
  [[ "$HOST" == "DietPi" ]] || [[ "$HOST" == "orangepi" ]]
}

add-unique-line-to-file() {
  local line=${1}
  local file=${2}
  if [[ -z $(cat $file | grep $line) ]]; then
    print-success "appending line to $file"
    echo "# updated by add-unique-line-to-file" >> $file
    echo $line >> $file
  fi
}

get-enclosing-folder() {
  P=${0:h}
  echo $P
}

restart-shell() {
  printf "\n"
  print-message "restart your session to load the new settings"
  printf "\n\t"
  print-message "$ source ~/.zshrc"
  printf "\n"
}

symlink() {
  if [[ $# -lt 2 ]]; then
    print-warning "symlink requires a source and a target, aborting"
    return 1
  fi

  local real=${1:a}
  local img=${2:a}

  if [[ ! -e $real ]]; then
    print-warning "the file ${real} does not exist, aborting"
    return 1
  fi

  # backup file
  if [[ -e $img ]]; then
    if [[ ! -e ${img}.backup ]]; then
      # only move the file if it the backup doesn't exist, that
      # way multiple calls with the same args won't overwrite
      # the first file
      print-warning "[FILE EXISTS] ${img} ... leaving original at ${img}.backup"
      mv ${img} ${img}.backup
    else
      print-warning "[BACKUP EXISTS] ${img}.backup ... leaving it untouched and removing ${img}"
      rm -f ${img}
    fi
  fi

  mkdir -p `dirname ${img}`
  ln -nfs $real $img

  print-success "${real} <- ${img}"
}
