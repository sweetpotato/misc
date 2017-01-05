#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

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
(
	if [ "$filter" = yes ] ; then
		find-data-filtered "$nr_new" "$nr_cont"
	else
		find-data
	fi
) | make-ranking "$target"
