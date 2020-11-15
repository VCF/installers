#!/bin/bash

## Location of the executable:
PROGDIR="Windward"
LAUNCH="Windward.x86"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/Winward"
INSTNAME='WindwardLinux_HB_*.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/$PROGDIR"

## Custom function to run after installation:
function INSTFUNCTION {
    ## Set the program to be executable
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
