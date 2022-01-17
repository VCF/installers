#!/bin/bash

## Location of the executable:
PROGDIR="Transcendence"
LAUNCH="Transcendence.exe"

## Location of the installer on your file system:
INSTDIR="Other/$PROGDIR"
INSTNAME='Transcendence.zip'
UNPACKDIR="$PROGDIR"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="32"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Games"

## Notes shown before program is executed
PRERUN="
https://multiverse.kronosaur.com/index.hexm
"

find_and_run_executable "$@"
