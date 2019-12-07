#!/bin/bash

## Location of the executable:
PROGDIR="Fox and Flock"
LAUNCH="foxandflock.sh"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='ff-linux-64.zip'
## Installation post-processing:
INSTICON="$PROGDIR.png"
## INSTRENAME='FORCED_Linux/'$PROGDIR
## UNPACKDIR="$PROGDIR"
INSTSAVEDIR="$HOME/.config/Fox & Flock"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {
    ## Executable needs to be set on main program
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
