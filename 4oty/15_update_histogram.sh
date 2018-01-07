#!/bin/bash
export LANG=C LC_ALL=C
set -xue

### query template ###
template1() {
	printf \
	"SELECT title_id FROM %s_aggregate WHERE n_users>1" \
	"$1"
}

template2() {
	printf \
	"SELECT LENGTH(desc) AS len FROM %s WHERE title_id='%s' ORDER BY len DESC;" \
	"$1" "$2"
}

template3() {
	printf \
	"UPDATE %s_aggregate SET histogram='%s' WHERE title_id='%s';" \
	"$1" "$3" "$2"
}

### main ###
sqlfile="${0##*/}.$$.tmp"
rm -f "$sqlfile"
echo 'BEGIN;' >>"$sqlfile"
for i in newbook contbook ; do
	query1=$(template1 "$i")
	books=($(sqlite3 -noheader -newline ' ' 4oty.db "$query1"))
	for j in "${books[@]}" ; do
		query2=$(template2 "$i" "$j")
		histogram=$(sqlite3 -noheader -newline ';' 4oty.db "$query2")
		query3=$(template3 "$i" "$j" "$histogram")
		echo "$query3" >>"$sqlfile"
	done
done
echo 'COMMIT;' >>"$sqlfile"

sqlite3 -noheader 4oty.db <"$sqlfile"
rm -f "$sqlfile"

exit 0
