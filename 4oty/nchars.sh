#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otynchars"

# check argument
target="$1"
is-any-of "$target" newbook newbook_ contbook || exit 1
shift 1

# run
make-nchars "$target"
