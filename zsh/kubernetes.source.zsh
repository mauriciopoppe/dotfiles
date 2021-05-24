function kc_taint_linux() {
  kubectl get nodes -l beta.kubernetes.io/os=linux -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule
    done
}

function kc_untaint_linux() {
  kubectl get nodes -l beta.kubernetes.io/os=linux -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule-
    done
}

function kc_taint_windows() {
  kubectl get nodes -l beta.kubernetes.io/os=windows -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule
    done
}

function kc_untaint_windows() {
  kubectl get nodes -l beta.kubernetes.io/os=windows -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule-
    done
}

# Escapes a kubernetes E2E test to a format that can be sent to ginkgo
# Usage:
#
#       $(ginkgo_escape_testname "[sig-storage] CSI Volumes ....")
#
function ginkgo_escape_testname() {
  local t=$1
  t=$(echo $t \
    | sed 's/(/\\(/g' | sed 's/)/\\)/g' \
    | sed 's/\[/\\\[/g' | sed 's/\]/\\\]/g' \
    | sed 's/ /./g' \
  )
  echo $t
}
