#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
source "${0%/*}"/../wccheck.rc

[ -f "${0%/*}"/list.tsv ]
list=($(cut -f1 -s "${0%/*}"/list.tsv))

mkdir -p data
ymd=$(date +%Y%m%d)
for i in "${list[@]}" ; do
	url="https://comic.pixiv.net/magazines/$i"
	html="data/magazines-$i-$ymd.html"
	txt="${html%.*}.txt"
	if [ -f "$html" ] ; then continue ; fi
	fetch_and_parse "$url" "$html" "$txt"
	diff_latest_two "data/magazines-$i-*.txt"
done

exit 0
