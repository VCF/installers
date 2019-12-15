#!/bin/bash

## Location of the executable:
PROGDIR="Death Road to Canada"
LAUNCH="prog-linux"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='DeathRoadtoCanada-*-Linux-Humble.zip'
## Installation post-processing:
INSTICON="$PROGDIR.jpg"
INSTRENAME='linux64/'$PROGDIR
APTPACKAGES='libsdl2-mixer-2.0-0'
## UNPACKDIR="$PROGDIR"
INSTSAVEDIR="$HOME/.madgarden/DR2C"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

#function INSTFUNCTION {
#    ## Executable needs to be set on main program
#    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
#}

find_and_run_executable "$@"
