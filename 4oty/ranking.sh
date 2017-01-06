#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

function x-find-data() {
	if [ "$1" = yes ] ; then
		find-data-filtered "$2" "$3"
	else
		find-data
	fi
}

# parse option
filter=no
while getopts f: optchr ; do
	case $optchr in
	f)
		nr_new="${OPTARG%,*}"
		nr_cont="${OPTARG#*,}"
		is-non-negative-integer "$nr_new" "$nr_cont" || exit 1
		filter=yes
		;;
	\?)
		exit 1
		;;
	esac
done
shift $((OPTIND - 1))

# check argument
target="$1"
is-any-of "$target" newbook newbook_ contbook || exit 1
shift 1

# run
x-find-data "$filter" "${nr_new:-}" "${nr_cont:-}" | make-ranking "$target"
