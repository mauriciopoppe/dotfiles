function my::start_vm() {
  if [[ -z $(limactl list --json | jq -r 'select(.name == "debian")') ]]; then
    limactl start debian
  fi
  limactl shell --shell /usr/bin/zsh debian
}
