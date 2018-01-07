#!/bin/bash
export LANG=C LC_ALL=C
set -xue
. "${0%/*}/4otyrc"

### function ###
function get-all-users() {
	find-data | xargs grep -h ^neighbor | cut -f3 | sort -u
}

function get-untracked-users() {
	local users=($(get-all-users))
	for user in "${users[@]}" ; do
		[ -f "$DATA/${user##*/}.user.tsv" ] || echo "$user"
	done
}

### main ###
force=no
if [ "${1:-}" == -f ] ; then force=yes ; fi

if [ $force == yes ] ; then
	untracked=($(get-all-users))
else
	untracked=($(get-untracked-users))
fi

while [ 0 -lt "${#untracked[@]}" ] ; do
	for user in "${untracked[@]}" ; do
		curl -s "$user" |\
		"${0%/*}/4oty.pl" "$user" >"$DATA/${user##*/}.user.tsv"
	done
	untracked=($(get-untracked-users))
done
