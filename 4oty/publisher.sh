#!/bin/bash
export LANG=C LC_ALL=C
set -ux
source "${0%/*}/4otyrc"

# parse option
sub=no
while getopts s optchr ; do
	case $optchr in
	s)
		sub=yes
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
if [ "$sub" = yes ] ; then
	find-data | xargs grep -h "^$target" | cut -f3 | sed 's!.*/dp/!!' |\
	"${0%/*}/isbn.pl" | cut -f1,2 | count |\
	awk '$3!="-"{print $2,$1,$3}' | sort -n -r |\
	awk-otsv '{print $1,$3,$2}'
else
	find-data | xargs grep -h "^$target" | cut -f3 | sed 's!.*/dp/!!' |\
	"${0%/*}/isbn.pl" | cut -f1 | count | sort -n -r |\
	awk-otsv '{print $2,"","",$1}'
fi
