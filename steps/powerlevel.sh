#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
source ../scripts/helpers.sh || exit 1
op 'Installing powerlevel10k...' \
  " [[ -d ~/powerlevel10k ]] && yes | rm -r ~/powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k &&
    printf '\nsource ~/powerlevel10k/powerlevel10k.zsh-theme\n' >>~/.zshrc" \
  'Successfully installed powerlevel10k' \
  'Failed to install powerlevel10k'
