#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otyrankingrc"

target=$1
new_=$2
cont=$3

find-data |\
xargs grep -c ^newbook_ | grep ":$new_" | awk -F: '{print $1;}' |\
xargs grep -c ^contbook | grep ":$cont" | awk -F: '{print $1;}' |\
make-ranking "$target"
