#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ./scripts/helpers.sh

RUN_FINAL="cd $(pwd)"
export RUN_FINAL

run ./steps/yay.sh
run ./steps/brew.sh
run ./steps/glab.sh
run ./steps/gh.sh
run ./steps/haskell.sh
run ./steps/sys-packages.sh
run ./steps/memory.sh
run ./steps/gnome.sh
run ./steps/zsh.sh
run ./steps/code-config.sh
