#!/bin/bash
source "${0%/*}/4otyrc"

function get-untracked-users() {
	local users=($(\
		grep -hR '^neighbor' "$DATA" | cut -s -f 3 | sort | uniq \
	))
	for user in "${users[@]}" ; do
		[ -f "$DATA/${user##*/}.tsv" ] || echo "$user"
	done
}

untracked=($(get-untracked-users))
while [ 0 -lt "${#untracked[@]}" ] ; do
	for user in "${untracked[@]}" ; do
		"$BIN/4oty.pl" "$user" >"$DATA/${user##*/}.tsv"
	done
	untracked=($(get-untracked-users))
done
