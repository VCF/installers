#!/bin/bash

## Location of the executable:
PROGDIR="Hammer Watch"
LAUNCH="Hammerwatch.bin.x86_64"

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='hammerwatch_linux_*.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Parameters for archives (zip/gz):
## Define a parent directory for unpacking archives:
UNPACKDIR="$PROGDIR"

### Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/saves"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Setting program to be executable"
    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
}

find_and_run_executable "$@"
