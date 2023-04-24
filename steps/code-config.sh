#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
source ../scripts/helpers.sh || exit 1

print_info 'Installing code extensions...'
while read -r line; do
  code --install-extension "$line"
done <../code-packages.txt ||
  print_error 'Failed to install code extensions.' ||
  exit $?

print_ok 'Successfully installed code extensions.'

op 'Copying code settings...' \
  "cp -f ../settings.json $HOME/.config/Code/User/settings.json" \
  'Successfully copied code settings.' \
  'Failed to copy code settings.' || exit $?
