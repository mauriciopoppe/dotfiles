#!/bin/zsh
autoload is-at-least

command-exists() {
  type $1 > /dev/null
}

is-macos() {
  [[ $OSTYPE =~ ^darwin ]] || return 1
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

  local src=${1:a}
  local tgt=${2:a}

  if [[ ! -e $src ]]; then
    print-warning "the file ${src} does not exist, aborting"
    return 1
  fi

  # backup file
  if [[ -e $tgt ]]; then
    if [[ ! -e ${tgt}.backup ]]; then
      # only move the file if it the backup doesn't exist, that
      # way multiple calls with the same args won't overwrite
      # the first file
      print-warning "[FILE EXISTS] ${tgt} ... leaving original at ${tgt}.backup"
      mv ${tgt} ${tgt}.backup
    else
      print-warning "[BACKUP EXISTS] ${tgt}.backup ... leaving it untouched and removing ${tgt}"
      rm -f ${tgt}
    fi
  fi

  mkdir -p `dirname ${tgt}`
  ln -nfs $src $tgt

  print-success "${src} -> ${tgt}"
}
