#!/bin/bash

## Location of the executable:
PROGDIR="Gang Beasts"
LAUNCH="Gang Beasts.x86"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='gangbeasts_linux_*.zip'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTRENAME='Linux/'$PROGDIR
## UNPACKDIR="$PROGDIR"
INSTSAVEDIR="$HOME/.config/unity3d/Boneloaf/Gang Beasts"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {
    ## Executable needs to be set on main program
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
