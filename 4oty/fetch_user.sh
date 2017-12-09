#!/bin/sh
export LANG=C LC_ALL=C
set -xu

bin="${0%/*}"
year=$(date +%Y)
mkdir -p data

ret=0
for i in "$@" ; do
	url="http://4oty.net/$year/user/$i"
	file="$bin/data/$i.tsv"
	curl -s "$url" | "$bin/4oty.pl" "$url" >"$file"
	if [ $? -ne 0 ] ; then ret=1 ; fi
done

exit $ret
