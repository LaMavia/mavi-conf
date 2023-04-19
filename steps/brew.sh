#!/usr/bin/env bash

base=$(dirname $0)
cd $base || exit 1
source ../scripts/helpers.sh || exit 1

op 'Installing homebrew...' \
  ' /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo '\''eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'\'') >> "$HOME/.zprofile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo pacman -S base-devel
  ' \
  'Succesfully installed homebrew.' \
  'Failed to install homebrew.' || exit 1
