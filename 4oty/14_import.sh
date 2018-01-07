#!/bin/bash
export LANG=C LC_ALL=C
set -xue

force=no
if [ "${1:-}" == -f ] ; then force=yes ; fi
if [ $force == no -a -f 4oty.db ] ; then exit 1 ; fi

rm -f 4oty.db.tmp
sqlite3 4oty.db.tmp <4oty.sql
mv -f 4oty.db.tmp 4oty.db

exit 0
