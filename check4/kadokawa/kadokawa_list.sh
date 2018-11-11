#!/bin/bash
export LANG=C LC_ALL=C
set -uo pipefail
bin="${0%/*}"
self="${0##*/}"

. "$bin"/../fun

list=kadokawa.txt

make_url() {
	local title="$1"
	local encoded=$(urlencode "$title")

	# "productForm=5": 商品形態=コミック
	# "sort=0": 表示順序=発売日順
	printf 'https://www.kadokawa.co.jp/product/search/?productForm=5&sort=0&kw=%s' "$encoded"
}

parse_list() {
	local html="$1"
	local text="$2"

	perl -I"$bin"/.. "$bin/${self%.*}.pl" <"$html" | sort | uniq >"$text"
}

dt=$(date +%Y%m%dT%H0000)
ret=0
load_list <"$bin/$list" | while read title ; do
	url=$(make_url "$title")
	hash=$(hashcode "$title")
	dir=data/"$hash"
	html="$dir/$dt.html"
	text="${html%.*}".txt

	mkdir -p "$dir"

	if [ ! -f "$html" ] ; then
		sleep 1
		if ! fetch_url "$url" "$html" ; then
			ret=1
			continue
		fi
	fi

	if [ ! -f "$text" ] ; then
		if ! parse_list "$html" "$text" ; then
			ret=1
			continue
		fi
	fi
done

exit $ret
