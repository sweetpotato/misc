#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

# check argument
target="$1"
is-any-of "$target" newbook newbook_ contbook || exit 1
shift 1

# run
for i in "$@" ; do
	make-cooccur "$target" "$i"
done
