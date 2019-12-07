#!/bin/bash

## Location of the executable:
PROGDIR="Forced"
LAUNCH="FORCED.sh"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='FORCED_Linux.zip'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTRENAME='FORCED_Linux/'$PROGDIR
##UNPACKDIR="$PROGDIR"
INSTSAVEDIR="$HOME/.config/unity3d/BetaDwarf ApS/FORCED"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {
    ## Executable needs to be set on main program
    chmod u+x "$GAMEDIR/$PROGDIR/FORCED/FORCED.x86_64"
}

find_and_run_executable "$@"
