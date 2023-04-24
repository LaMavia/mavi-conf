#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Installing gh...' \
  'brew install gh' \
  'Successfully installed gh.' \
  'Failed to install gh.' || exit 1

print_info 'Would you like to authenticate gh now? (y/n) '
read -pr '' confirm
if [[ $confirm == [YySs] ]]; then
  gh auth login || exit 1
fi
