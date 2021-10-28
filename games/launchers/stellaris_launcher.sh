#!/bin/bash

## Location of the executable:
PROGDIR="Stellaris"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='stellaris_2*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Paradox Interactive/Stellaris"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Installing DLCs"
    addDLC 'stellaris_horizon_signal_*.sh'
}

find_and_run_executable "$@"
