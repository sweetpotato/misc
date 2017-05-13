#!/bin/bash
export LANG=C LC_ALL=C
set -xueo pipefail
bin="${0%/*}"

subdirs=($(find "$bin" -mindepth 1 -maxdepth 1 -type d -not -name '_*'))

for i in "${subdirs[@]}" ; do
	if [ ! -x "$i"/run.sh ] ; then continue ; fi
	"$i"/run.sh ||:
done
