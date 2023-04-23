#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ./scripts/helpers.sh
root_dir=$(pwd)

# yay
source ./steps/yay.sh || exit $?
cd "$root_dir" || exit 1

# brew
source ./steps/brew.sh || exit $?
cd "$root_dir" || exit 1

# glab
source ./steps/glab.sh || exit $?
cd "$root_dir" || exit 1

# github-cli
source ./steps/gh.sh || exit $?
cd "$root_dir" || exit 1

# haskell
source ./steps/haskell.sh || exit $?
cd "$root_dir" || exit 1

# Further packages
source ./steps/sys-packages.sh || exit $?
cd "$root_dir" || exit 1

# disable cache
source ./steps/memory.sh || exit $?
cd "$root_dir" || exit 1

# gnome config
cd "$root_dir" || exit 1
source ./steps/gnome.sh || exit 1
