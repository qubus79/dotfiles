#!/usr/bin/env bash

set -euoE pipefail

install_zsh() {
  echo "🚀 [zsh] shell changing..."
  apt="sudo apt -y"
  $apt install curl wget git
  $apt update
  $apt install zsh
  chsh -s $(which zsh)
}

install_ohmyzsh() {
  echo "🚀 [OhMyZsh] installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  echo "🚀 [PowerLevel10K] installing..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  
  echo "🚀 [OhMyZsh Plugins] installing..."
  git clone [https://github.com/zsh-users/zsh-autosuggestions.git](https://github.com/zsh-users/zsh-autosuggestions.git) $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone [https://github.com/zsh-users/zsh-syntax-highlighting.git](https://github.com/zsh-users/zsh-syntax-highlighting.git) $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  
  echo "✅ [OhMyZsh] installed!"
}

if test "$(uname -s)" == "Linux"; then
  install_zsh
fi
install_ohmyzsh
