#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ../scripts/helpers.sh || exit 1

op 'Loading gnome config...' \
  'dconf load / < dconf-settings.ini' \
  'Successfully loaded gnome config.' \
  'Failed to load gnome config.' || exit 1

