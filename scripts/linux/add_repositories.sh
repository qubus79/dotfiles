#!/usr/bin/env bash

set -euoE pipefail

# shellcheck disable=SC2086
cwd="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"

# Wezterm repository
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

# Syncthing
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

apt="sudo apt -y"
$apt update

# sudo add-apt-repository --yes --update ppa:ansible/ansible

# install_from_package_list() {
#   export DEBIAN_FRONTEND=noninteractive
#   packages="$(awk '! /^ *(#|$)/' "$1")"
#   xargs -a <(echo "$packages") -r -- echo "⚪ [apt] installing packages:"
#   xargs -a <(echo "$packages") -r -- $apt --no-install-recommends install
# }

# install_from_package_list "${cwd}/essentials.apt"


$apt install syncthing
$apt install wezterm