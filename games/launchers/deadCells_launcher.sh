#!/bin/bash

## Location of the executable:
PROGDIR="Dead Cells"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='dead_cells_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/game/save"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Installing DLCs"
    addDLC 'dead_cells_rise_of_the_giant_*.sh'
}


find_and_run_executable "$@"
