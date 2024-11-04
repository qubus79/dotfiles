#!/usr/bin/env bash

set -euoE pipefail

# shellcheck disable=SC2086
# cwd="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
apt="sudo apt -y"

echo "🚀 [Wezterm] installing..."
# Wezterm install
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
$apt update
$apt install wezterm

echo "🚀 [syncthing] installing..."
# Syncthing install
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
$apt install syncthing

echo "🚀 [GitKraken] installing"
# GitKraken install
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
$apt install ./gitkraken-amd64.deb

echo "🚀 [Sublime Txt] installing..."
# Sublime Text install
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
$apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
$apt update
$apt install sublime-text

# echo "🚀 [Sublime Merge] installing..."
# Sublime Merge install
# $apt install sublime-merge

echo "🚀 [Tailscale] installing..."
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up


echo "✅ Additional software installed"









