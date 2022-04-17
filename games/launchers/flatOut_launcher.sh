#!/bin/bash

## Location of the executable:
PROGDIR="FlatOut"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Flatout"
INSTNAME='flatout_gog_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Flatout.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/prefix/drive_c/GOG Games/FlatOut/Savegame"

find_and_run_executable "$@"
