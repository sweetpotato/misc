#!/bin/bash
export LANG=C LC_ALL=C
set -xue

which sqlite3 >&2 || exit 1
[ -f 4oty.db ] || exit 1

sqlfile="${1:-}"
[ -n "${sqlfile:-}" ] || exit 1
[ -f "$sqlfile" ] || exit 1

sqlite3 -header -quote -csv 4oty.db <"$sqlfile"

exit 0
