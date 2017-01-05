#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

# check argument
target="$1"
is-any-of "$target" newbook newbook_ contbook || exit 1
shift 1

# run
join -t $'\t' \
<(find-data | make-ranking "$target" |\
  awk-tsv '{print $2,$3,$1}' | sort -k1,1) \
<(find-data | make-nchars "$target" |\
  cut -f3,6 | awk-tsv -f aggregate_nchars.awk | sort -k1,1) |\
awk-tsv '{print $6,$4,$5,$3,$1,$2}'
