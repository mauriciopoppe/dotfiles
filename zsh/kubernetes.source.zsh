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

# connects to a GCP Windows VM running kubernetes
# NOTE: assumes that it there's only a single kubernetes node
function kwinssh () {
  local windows_node=$(kubectl get nodes -l kubernetes.io/os=windows -o jsonpath='{.items[*].metadata.name}')
  gcloud compute ssh $windows_node
}
