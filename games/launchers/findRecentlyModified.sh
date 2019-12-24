#!/bin/bash

## Find recently (24hr) modified files in home directory, filtering
## out irrelevant matches

srcDir="${1-$HOME}"
echo "Finding recently modified files in $srcDir"

isWine="$(echo "$srcDir") | egrep -o Wine)"
[[ -n "$isWine" ]] && isWine="Wine|"

find "$srcDir" -mtime -1 |\
    egrep -v "(${isWine}waterfox|gimp|cache|Browser|confFiles|emacs)" |\
    egrep -v '(Desktop|Programs|icons|GameFiles|zeitgeist|generalUtilities)' |\
    egrep -v '(installers|pulse|Downloads|Trash|QMapShack|dolphin)' |\
    egrep -v '(RecentDocuments|kactivitymanagerd|libreoffice)' |\
    less -S
