#!/bin/bash

## Loops through all directories in $SAVEDIR (defined in
## _launcher_functions.sh) and backs them up if needed

my_dir="$(dirname "$0")"
. "$my_dir/launchers/_launcher_functions.sh"

## Save file listing loop: https://stackoverflow.com/a/7039208
find "$SAVEDIR" -maxdepth 1 -mindepth 1 -type d | while read PROGPATH
do
    PROGDIR=`basename "$PROGPATH"`
    [[ "$PROGDIR" =~ ^\. ]] && continue # Skip dot files
    msg "$FgWhite" "$PROGDIR"
    archiveFolder "$PROGPATH" "GameFiles"
done
