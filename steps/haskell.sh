#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Installing ghcup dependencies...' \
  'yes | head -n1 | sudo pacman -Syu curl gcc gmp make ncurses coreutils xz' \
  'Successfully installed ghcup dependencies.' \
  'Failed to install ghcup dependencies.' || exit 1

op 'Installing ghcup...' \
  'curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh' \
  'Successfully installed ghcup.' \
  'Failed to install ghcup.' || exit 1

source "$HOME/.ghcup/env"
