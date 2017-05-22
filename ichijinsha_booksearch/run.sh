#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
base='http://data.ichijinsha.co.jp/book/booksearch/booksearch_list.php'
bin="${0%/*}"

dtstr="${1:-last month}"
dt=$(date --date="${dtstr}" +%Y/%m)
y="${dt%/*}"
m="${dt#*/}"

mkdir -p data

txt="data/${y}-${m}.txt"
truncate --size=0 "${txt}"
[ -w "${txt}" ]
for (( i=0; i<10; i++ )) ; do
	url="${base}?SALEY=${y}&SALEM=${m}&page=${i}"
	html="data/${y}-${m}-${i}.html"
	curl -o "${html}" "${url}"
	[ -f "${html}" ]
	chmod 444 "${html}"

	set +e
	perl -CS "${bin}/parse.pl" <"${html}" >>"${txt}"
	code=$?
	set -e

	if [ $code -ge 2 ] ; then exit 1 ; fi
	if [ $code -eq 1 ] ; then break ; fi
done

exit 0
