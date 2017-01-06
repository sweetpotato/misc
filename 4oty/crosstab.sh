#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

join -t: \
  <(find-data | xargs grep -c ^newbook_ | sort -t: -k1,1) \
  <(find-data | xargs grep -c ^contbook | sort -t: -k1,1) |\
awk -F: '{print $2,$3}' | sort -n -r | uniq -c |\
awk -v OFS=$'\t' -f print_crosstab.awk
