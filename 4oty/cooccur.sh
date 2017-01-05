#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otycooccurrc"

# check argument
target="$1"
is-any-of "$target" newbook newbook_ contbook || exit 1
shift 1

# run
for i in "$@" ; do
	make-cooccur "$target" "$i"
done
