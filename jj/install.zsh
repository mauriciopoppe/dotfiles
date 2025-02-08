#!/bin/zsh

local base=${0:h}

main() {
  print-header "jj"

  # The file isn't part of the repo.
  symlink "${base}/../secret/jjconfig.mine.toml" "${HOME}/.jjconfig.toml"
}

main $@

