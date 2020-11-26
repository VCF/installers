#!/bin/bash

## Location of the executable:
PROGDIR="Mirrors Edge"
LAUNCH="MirrorsEdge.exe"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="Binaries"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_mirrors_edge_*.exe'

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
## The location of the installed program in drive_c:
WINETARGET="GOG Games/Mirror's Edge"
## Any winetricks that might be needed:
INSTTRICKS="physx"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/EA Games/Mirror's Edge/TdGame/Savefiles"

## Notes shown before program is executed
PRERUN="
May need to launch a couple times to make functional?
"

find_and_run_executable "$@"
