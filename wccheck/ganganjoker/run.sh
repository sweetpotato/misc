#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
source "${0%/*}"/../wccheck.rc

url=http://www.jp.square-enix.com/magazine/joker/series/index.html
fetch_and_parse_today_data "$url"
diff_latest_two_data_txt

exit 0
