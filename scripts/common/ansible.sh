#!/usr/bin/env bash

set -euoE pipefail

# shellcheck disable=SC2086
cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_collections() {
  echo "🚀 [ansible] installing collections..."
  ansible-galaxy collection install community.general
}

run_playbook() {
  echo "🚀 [ansible] running playbook..."
  local playbook_opts=""
  local uname_s
  uname_s="$(uname -s)"

  # Na macOS nie używamy sudo/become (Homebrew nie może być uruchamiany jako root),
  # na Linuxie i innych systemach prosimy o hasło sudo przez --ask-become-pass.
  if [[ "$uname_s" != "Darwin" ]]; then
    playbook_opts="--ask-become-pass"
  fi

  export ANSIBLE_CONFIG="${cwd}/ansible/ansible.cfg"

  echo "🔧 [ansible] używam ANSIBLE_CONFIG=${ANSIBLE_CONFIG}"
  echo "📂 [ansible] playbook: ${cwd}/ansible/main.yaml"
  echo "👤 [ansible] użytkownik: $(whoami)"
  echo "⚙️  [ansible] dodatkowe opcje: ${playbook_opts}"

  echo "ansible-playbook -e ansible_user=$(whoami) ${cwd}/ansible/main.yaml -vv ${playbook_opts}"
  ansible-playbook -e "ansible_user=$(whoami)" "${cwd}/ansible/main.yaml" -vv ${playbook_opts}
  echo "✅ [ansible] configured!"
}

# process arguments
while [[ $# -gt 0 ]]; do
  arg=$1
  case $arg in
    --install)
      install_collections
      ;;
    --run)
      run_playbook
      ;;
    --all)
      install_collections
      run_playbook
      ;;
  esac
  shift
done
