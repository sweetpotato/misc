#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

(
	grep -c ^newbook_ data/*.tsv | awk -F: '{print $1,"a",$2;}'
	grep -c ^contbook data/*.tsv | awk -F: '{print $1,"b",$2;}'
) | sort -k1,2 | xargs -n 6 echo | awk '{print $3,$6;}' | sort -n -r | uniq -c |\
awk -f print_crosstab.awk
