#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
source "${0%/*}"/../wccheck.rc

ymd=$(date +%Y%m%d)
# https://mangacross.jp/comics
html=data/index.html
txt="data/$ymd.txt"

[ -f "$html" ]
perl -CO -I"${0%/*}"/.. "${0%/*}"/parse.pl <"$html" | sort >"$txt"
chmod 444 "$txt"

diff_latest_two_data_txt

exit 0
