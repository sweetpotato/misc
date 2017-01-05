#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otynchars"

# check argument
mode="$1"
is-any-of "$mode" new1 newcont cont2 || exit 1
shift 1

book1="$1"
book2="${2:-}" # can be empty
shift 2

# run
data=($(find-data))

## step 1: filter by newbook
if [ "$mode" != cont2 ] ; then
	data=($( \
		echo "${data[@]}" |\
		xargs grep -l "$book1" |\
		xargs grep -c ^newbook_ |\
		awk -F: '$2==1{print $1;}' \
	))
else
	data=($( \
		echo "${data[@]}" |\
		xargs grep -c ^newbook_  |\
		awk -F: '$2==0{print $1;}' \
	))
fi

## step 2: filter by contbook
case "$mode" in
cont2)
	data=($( \
		echo "${data[@]}" |\
		xargs grep -c -e "$book1" -e "$book2" |\
		awk -F: '$2==2{print $1;}' |\
		xargs grep -c ^contbook |\
		awk -F: '$2==2{print $1;}' \
	))
	;;
newcont)
	data=($( \
		echo "${data[@]}" |\
		xargs grep -l "$book2" |\
		xargs grep -c ^contbook |\
		awk -F: '$2==1{print $1;}' \
	))
	;;
new1)
	data=($( \
		echo "${data[@]}" |\
		xargs grep -c ^contbook |\
		awk -F: '$2==0{print $1;}' \
	))
	;;
esac

## step 3: print
grep -h -v ^neighbor "${data[@]}"
