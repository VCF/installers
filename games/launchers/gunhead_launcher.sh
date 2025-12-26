#!/bin/bash

## Location of the executable:
PROGDIR="GUNHEAD"
LAUNCH="Gunhead.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_gunhead_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="64"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/AppData/LocalLow/Alientrap/Gunhead/Save"

## Notes shown before program is executed
PRERUN="
Wine Gold
  https://www.protondb.com/app/704000?device=pc
"

find_and_run_executable "$@"
