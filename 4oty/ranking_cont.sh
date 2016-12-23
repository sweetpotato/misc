#!/bin/bash
source "${0%/*}/4otyrc"
source "$BIN/4otyrankingrc"

find-data | make-ranking contbook
