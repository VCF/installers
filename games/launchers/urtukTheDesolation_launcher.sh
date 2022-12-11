#!/bin/bash

## Location of the executable:
PROGDIR="Urtuk The Desolation"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='urtuk_the_desolation_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
##  Saves are in the same folder as executable and supporting files
## INSTSAVEDIR="$GAMEDIR/$PROGDIR/game"

find_and_run_executable "$@"
