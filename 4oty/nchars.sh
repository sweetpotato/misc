#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otynchars"

# check argument
target="$1"
case "$target" in
newbook)
	;;
newbook_)
	;;
contbook)
	;;
*)
	exit 1
	;;
esac
shift 1

# run
make-nchars "$target"
