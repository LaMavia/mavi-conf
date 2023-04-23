#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Installing yay...' \
  'sudo pacman -Syu yay' \
  'Successfully installed yay.' \
  'Failed to install yay.' || exit 1
