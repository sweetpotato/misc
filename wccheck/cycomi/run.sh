#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
bin="${0%/*}"
source "$bin"/../wccheck.rc

# DO NOT include "/serialization/7"
urls=( \
	https://cycomi.com/fw/cycomibrowser/title/serialization/0 \
	https://cycomi.com/fw/cycomibrowser/title/serialization/1 \
	https://cycomi.com/fw/cycomibrowser/title/serialization/2 \
	https://cycomi.com/fw/cycomibrowser/title/serialization/3 \
	https://cycomi.com/fw/cycomibrowser/title/serialization/4 \
	https://cycomi.com/fw/cycomibrowser/title/serialization/5 \
	https://cycomi.com/fw/cycomibrowser/title/serialization/6 \
)

ymd=$(date +%Y%m%d)
html="$bin"/data/"$ymd".html
txt="${html%.*}".txt

mkdir -p "$bin"/data
[ -f "$html" ] && exit 1

# fetch
touch "$html"
for url in "${urls[@]}" ; do
	curl "$url" >>"$html"
done
chmod 444 "$html"

# parse
perl -CO -I "$bin"/.. "$bin"/parse.pl <"$html" | sort | uniq >"$txt"
chmod 444 "$txt"

diff_latest_two_data_txt

exit 0
