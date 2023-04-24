#!/usr/bin/bash

function print {
  echo -e "[$1] \e[1m$2\e[0m"
}

function print_info {
  print "\e[1;96mINFO\e[0m" "$1"
}

function print_ok {
  print "\e[1;92mOK\e[0m" "$1"
}

function print_error {
  print "\e[1;91mERROR\e[0m" "$1"
}

function is_detached {
  ! git symbolic-ref -q HEAD
}

function branch_name {
  if is_detached; then
    exit 1
  fi

  git branch --show-current
}

function op {
  local fail

  print_info "$1"
  if eval "$2"; then
    print_ok "$3"
    if [ -n "$OP_OK" ]; then
      eval "$OP_OK"
      unset OP_OK
    fi
  else
    print_error "$4: $?"
    if [ -n "$OP_ERR" ]; then
      eval "$OP_ERR"
      unset OP_ERR
    fi
    fail=true
  fi

  if [ -n "$OP_FINAL" ]; then
    print_info "Running final hook: $OP_FINAL"
    eval "$OP_FINAL"
    unset OP_FINAL
  fi

  if [[ $fail = true ]]; then
    exit 1
  fi
}

function run() {
  local fail

  fname=$1
  shift

  source "$fname" "${@}"
  status=$?
  if [[ $status -eq 0 ]]; then
    print_ok "Finished $fname."
    if [ -n "$RUN_OK" ]; then
      eval "$RUN_OK"
    fi
  else
    print_error "Failed $fname: $status"
    if [ -n "$RUN_ERR" ]; then
      eval "$RUN_ERR"
    fi
    fail=true
  fi

  if [ -n "$RUN_FINAL" ]; then
    eval "$RUN_FINAL"
  fi

  if [[ $fail = true ]]; then
    exit 1
  fi
}
