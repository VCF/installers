#!/bin/bash

## Location of the executable:
PROGDIR="Steam Marines"
LAUNCH="run.sh"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Steam_Marines_*.zip'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Installation post-processing:
INSTRENAME='Steam_Marines_*/'"$PROGDIR"
## Save directory is under a literal '~' - probably a shell error on their part
## THis causes problems making the symlink
# INSTSAVEDIR="$GAMEDIR/$PROGDIR/"'~/Worthless Bums/Steam Marines/'
INSTICON="$PROGDIR.png"
## A couple 32-bit packages needed on amd64 systems:
APTPACKAGES="
libxft2:i386
libsdl1.2debian:i386
"

function INSTFUNCTION {
    ## Executable needs to be set on main program
    chmod u+x "$GAMEDIR/$PROGDIR/Steam Marines"
}

find_and_run_executable "$@"

