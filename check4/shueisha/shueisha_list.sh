#!/bin/bash
export LANG=C LC_ALL=C
set -uo pipefail
bin="${0%/*}"

. "$bin"/../fun

list=shueisha.txt

make_url() {
	local title="$1"
	local encoded=$(urlencode "$title")

	printf 'http://www.s-manga.net/search/search.html?titleauthor=%s' "$encoded"
}

extract_json() {
	local html="$1"
	local json="$2"

	grep '^var ssd = ' <"$html" | head -n 1 |\
	sed -r -e 's/^var ssd = //' -e 's/;$//' >"$json"
}

dt=$(date +%Y%m%dT%H0000)
ret=0
load_list <"$bin/$list" | while read title ; do
	url=$(make_url "$title")
	hash=$(hashcode "$title")
	dir=data/"$hash"
	html="$dir/$dt.html"
	json="${html%.*}.json"

	mkdir -p "$dir"

	if [ ! -f "$html" ] ; then
		sleep 1
		if ! fetch_url "$url" "$html" ; then
			ret=1
			continue
		fi
	fi

	if [ ! -f "$json" ] ; then
		if ! extract_json "$html" "$json" ; then
			ret=1
			continue
		fi
	fi

	if ! jq -c -r -f "$bin"/shueisha.jq <"$json" | awk -f "$bin"/shueisha.awk ; then
		ret=1
		continue
	fi
done

exit $ret
