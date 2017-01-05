#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

(
	find-data | xargs grep -c ^newbook_ | awk -F: '{print $1,"a",$2}'
	find-data | xargs grep -c ^contbook | awk -F: '{print $1,"b",$2}'
) | sort -k1,2 | xargs -n 6 echo | awk '{print $3,$6}' | sort -n -r |\
    uniq -c | awk -v OFS=$'\t' -f print_crosstab.awk
