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
