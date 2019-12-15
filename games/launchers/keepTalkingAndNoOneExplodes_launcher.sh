#!/bin/bash

## Location of the executable:
PROGDIR="Keep Talking and Nobody Explodes"
LAUNCH="ktane.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Keep_Talking_and_Nobody_Explodes_*_-_Linux.zip'
## Installation post-processing:
INSTICON="$PROGDIR.png"
## INSTRENAME='linux64/'$PROGDIR
## APTPACKAGES='libsdl2-mixer-2.0-0'
## UNPACKDIR="$PROGDIR"
INSTSAVEDIR="$HOME/.config/unity3d/Steel Crate Games/Keep Talking and Nobody Explodes"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {
    ## Executable needs to be set on main program
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
