function kutils::taint-linux() {
  kubectl get nodes -l beta.kubernetes.io/os=linux -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule
    done
}

function kutils::untaint-linux() {
  kubectl get nodes -l beta.kubernetes.io/os=linux -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule-
    done
}

function kutils::taint-windows() {
  kubectl get nodes -l beta.kubernetes.io/os=windows -o name | \
    while IFS= read -r node; do
      kubectl taint node $node node.kubernetes.io/os:NoSchedule
    done
}

function kutils::untaint-windows() {
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
function kutils::ginkgo-escape-testname() {
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
function kutils::gcloud-ssh-windows-node () {
  local windows_node=$(kubectl get nodes -l kubernetes.io/os=windows -o jsonpath='{.items[*].metadata.name}')
  gcloud compute ssh $windows_node
}

function kutils::kubelet-recompile() {
  # Make sure that we're in the right location (the kubernetes codebase)
  if [[ ! -f $PWD/hack/lib/golang.sh ]]; then
    echo "ERROR: This script must be run from the kubernetes codebase"
    return 1
  fi

  # Make sure that the custom make-in-container.sh script exists
  if [[ ! -f $PWD/build/make-in-container.sh ]]; then
    echo "ERROR: The script build/make-in-container.sh does not exist"
    return 1
  fi

  # Make sure that there's a kind cluster running
  if [[ ! $( docker ps -a -f name=kind-worker | wc -l ) -ge 2 ]]; then
    echo "ERROR: There's no kind cluster running"
    return 1
  fi

  echo "Recompiling kubelet"
  KUBE_VERBOSE=0 KUBE_FASTBUILD=true KUBE_RELEASE_RUN_TESTS=n \
    ./build/make-in-container.sh make all WHAT=cmd/kubelet DBG=1

  echo "Restarting kubelet"
  docker cp _output/dockerized/bin/linux/arm64/kubelet kind-worker:/usr/bin/kubelet
  docker exec -i kind-worker bash -c "systemctl daemon-reload; systemctl restart kubelet"
}
