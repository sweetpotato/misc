#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
source "${0%/*}"/../wccheck.rc

url=https://web-ace.jp/youngaceup/contents/
fetch_and_parse_today_data "$url"
diff_latest_two_data_txt

exit 0
