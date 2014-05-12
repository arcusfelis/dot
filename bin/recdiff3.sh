#!/bin/bash
# For each OLD ($2) file compare MY ($1) file with YOUR ($2) file and write results into YOUR files.
for i in "$2"/*; do b=$(basename "$i"); diff3 -e "$1/$b" "$2/$b" "$3/$b"  ; done
#> "$3/$b"
