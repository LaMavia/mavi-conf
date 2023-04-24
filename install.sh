#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ./scripts/helpers.sh

RUN_FINAL="cd $(pwd)"
export RUN_FINAL

steps=(yay brew glab gh haskell sys-packages memory gnome zsh code-config)
step0=$1

# Determine the index of the first step
declare i=0
for j in $(seq 0 $((${#steps[@]} - 1))); do
  s=${steps[$j]}

  if [[ "$s" == "$step0" ]]; then
    i=$j
    break
  fi
done

# Run each step starting at step0
j=0
for step in "${steps[@]}"; do
  if [[ $j -ge $i ]]; then
    run "./steps/$step.sh"
  fi
  ((j = j + 1))
done
