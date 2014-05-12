#!/bin/sh
# usage: scriptname file1 file2 ...

for file in "$@"
do
    [ -f "$file" ] || continue
    set -- `wc "$file"`
    echo "\n${file}: lines $1 words $2 bytes $3"
    cat -n -s "$file"
done
