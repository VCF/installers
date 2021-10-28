#!/bin/bash

## Location of the executable:
PROGDIR="V Rings of Saturn"
LAUNCH="start.sh"
## What I've named the folder:
PDIR2="Delta $PROGDIR"

## Location of the installer on your file system:
INSTDIR="GOG/$PDIR2"
INSTNAME='_v_rings_of_saturn_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PDIR2.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/dV"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Installing DLCs"
    addDLC '_v_rings_of_saturn_tales_from_the_rings_*.sh'
}

find_and_run_executable "$@"
