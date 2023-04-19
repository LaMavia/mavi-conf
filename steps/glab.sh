#!/usr/bin/env bash

base=$(dirname $0)
cd "$base" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Installing glab...' \
  'brew install glab' \
  'Successfully installed glab.' \
  'Failed to install glab.' || exit 1

print_info 'Would you like to authenticate glab now? (y/n) '
read -pr confirm
if [[ $confirm == [YySs] ]]; then
  firefox 'https://gitlab.com/-/profile/personal_access_tokens'
  print_info 'Input your access token:'
  glab auth login || exit 1
fi
