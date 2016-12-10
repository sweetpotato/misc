#!/bin/bash
source "${0%/*}/4otyrc"

function get-untracked-users() {
	cat "$DATA"/*.tsv |\
	grep '^neighbor'  |\
	awk '{print $3;}' |\
	sort              |\
	uniq              |\
	xargs -n 1 bash -c '[ -f "$0/${1##*/}.tsv" ] || echo "$1"' "$DATA"
}

untracked=($(get-untracked-users))
while [ 0 -lt "${#untracked[@]}" ] ; do
	for user in "${untracked[@]}" ; do
		"$BIN/4oty.pl" "$user" >"$DATA/${user##*/}.tsv"
	done
	untracked=($(get-untracked-users))
done
