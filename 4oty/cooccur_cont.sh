#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otycooccurrc"

for i in "$@" ; do
	make-cooccur contbook "$i"
done
