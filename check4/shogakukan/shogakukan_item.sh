#!/bin/bash
export LANG=C LC_ALL=C
set -uo pipefail
bin="${0%/*}"
self="${0##*/}"

. "$bin"/../fun

list=shogakukan.txt
black=shogakukan_black.txt

parse_item() {
	local url="$1"
	local html="$2"
	perl -I"$bin"/.. "$bin/${self%.*}.pl" "$url" <"$html"
}

dt=$(date +%Y%m%dT%H0000)
ret=0
load_list <"$bin/$list" | while read title ; do
	hash=$(hashcode "$title")
	dir=data/"$hash"

	if [ ! -d "$dir" ] ; then
		ret=1
		continue
	fi

	text=$(find_latest_text "$dir")
	if [ -z "$text" ] ; then
		ret=1
		continue
	fi

	while read url ; do
		id=$(make_id "$url")
		html=data/"$id".html

		# skip if found in black list
		if load_list <"$bin/$black" | grep -q "$url" ; then
			continue
		fi

		if [ ! -f "$html" ] ; then
			sleep 1
			if ! fetch_url "$url" "$html" ; then
				ret=1
				continue
			fi
		fi

		if ! parse_item "$url" "$html" ; then
			ret=1
			continue
		fi
	done <"$text"
done

exit $ret
