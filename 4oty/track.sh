#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

function get-untracked-users() {
	local users=($(\
		find-data | xargs grep -h ^neighbor | cut -f3 | sort -u
	))
	for user in "${users[@]}" ; do
		[ -f "$DATA/${user##*/}.tsv" ] || echo "$user"
	done
}

untracked=($(get-untracked-users))
while [ 0 -lt "${#untracked[@]}" ] ; do
	for user in "${untracked[@]}" ; do
		curl -s "$user" |\
		"${0%/*}/4oty.pl" "$user" >"$DATA/${user##*/}.tsv"
	done
	untracked=($(get-untracked-users))
done
