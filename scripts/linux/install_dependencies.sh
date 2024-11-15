#!/usr/bin/env bash

set -euoE pipefail

# shellcheck disable=SC2086
cwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apt="sudo apt -y"
$apt update

# sudo add-apt-repository --yes --update ppa:ansible/ansible    # no repository for ubuntu oracular (24.10) yet
echo "🚀 [ansible] installing..."
brew install ansible
echo "✅ [ansible] installed"

install_from_package_list() {
  export DEBIAN_FRONTEND=noninteractive
  packages="$(awk '! /^ *(#|$)/' "$1")"
  xargs -a <(echo "$packages") -r -- echo "🚀 [apt] installing essential packages:"
  xargs -a <(echo "$packages") -r -- $apt --no-install-recommends install
}

echo "🚀 packages installing..."
install_from_package_list "${cwd}/essentials.apt"
echo "✅ packages installed"