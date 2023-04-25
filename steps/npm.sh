#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Preparing npm global settings...' \
  " mkdir -p ~/.npm-global  &&
    npm config set prefix '~/.npm-global' &&
    if [[ -z \$( cat ~/.zprofile | grep '.npm-global/bin:' ) ]]; then
      printf '\nexport PATH=~/.npm-global/bin:\$PATH\n' >> ~/.zprofile
    fi &&
    source ~/.zprofile
  " \
  'Successfully prepared npm -g.' \
  'Failed to prepare npm -g.' || exit $?
