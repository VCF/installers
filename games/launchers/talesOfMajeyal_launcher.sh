#!/bin/bash

## Location of the executable:
PROGDIR="Tales of MajEyal"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Tales of Majeyal"
INSTNAME='tales_of_maj_eyal_1_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.t-engine/4.0"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Installing DLCs"
    addDLC 'tales_of_maj_eyal_ashes_of_urh_rok_*.sh'
    addDLC 'tales_of_maj_eyal_embers_of_rage_*.sh'
}

find_and_run_executable "$@"
