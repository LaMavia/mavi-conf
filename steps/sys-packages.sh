#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Installing remaining pacman packages...' \
  'sudo pacman -Sy --needed --noconfirm - < ../packages.txt' \
  'Successfully installed remaining packages.' \
  'Failed to install remaining packages.' || exit 1

op 'Installing remaining aur packages...' \
  'yay -S --needed --noconfirm - < ../aur-packages.txt' \
  'Successfully installed remaining aur packages.' \
  'Failed to install remaining aur packages.' || exit 1
