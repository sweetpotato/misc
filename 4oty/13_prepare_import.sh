#!/bin/bash
export LANG=C LC_ALL=C
set -xue
. "${0%/*}/4otyrc"

### function ###
function scrub() {
	perl -CS -pe 's|https?://[\x21-\x7E]+||g;s|\s+||g;$_="$_\n"'
}

### main ###
find-data | xargs grep -h  ^neighbor | cut -f3,4 | sort -u >user.tsv
find-data | xargs grep -hv ^neighbor | cut -f3,4 | sort -u >title.tsv

for nc in newbook contbook ; do
	f="$nc.tsv.tmp"
	find-data | xargs grep -h "^$nc" | cut -f2,3,5 | sort -u >"$f"
	paste <(cut -f1,2 "$f") <(cut -f3 "$f" | scrub) >"${f%.tmp}"
	rm -f "$f"
done

exit 0
