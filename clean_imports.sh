#!/bin/bash

# Author: Paul Bourke <pauldbourke@gmail.com>
# Version: 0.1

# Find line numbers of unused imports, concatenate into a single line, and
# delete those lines from the file
OUT=$(eval "sed '`checkstyle -c /usr/share/checkstyle/sun_checks.xml $1 2>&1 \
    | grep -i 'unused import' | awk -F: '{ print $2 }' \
    | sed ':a;{N;s/\n/d;/;ba}'`d' $1")

# If we get no output from the above, there are no unused imports, just return
# the original file
if [ -z "$OUT" ]
then
    /bin/cat $1
else
    echo "$OUT"
fi

