# Called by p10k if the env var HTTP_PROXY is set
function prompt_my_http_proxy_set() {
  if [[ -z $HTTP_PROXY ]]; then
    return
  fi
  p10k segment -i '' -f 'blue'
}
