#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1
source ../scripts/helpers.sh || exit 1

sync
echo 1 | sudo tee /proc/sys/vm/dirty_expire_centisecs
echo 1 | sudo tee /proc/sys/vm/dirty_writeback_centisecs
echo 1 | sudo tee /proc/sys/vm/drop_caches
