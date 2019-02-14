#!/bin/bash

## Location of the executable:
PROGDIR="Convoy"
LAUNCH="Convoy.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Convoy_*_Linux.zip'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/Convoy Games/Convoy"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function INSTFUNCTION {
    msg "$FgMagenta" "  Setting program to be executable ..."
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"

