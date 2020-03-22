#!/bin/bash

## Location of the executable:
PROGDIR="Sacred Gold"
LAUNCH="Sacred.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_sacred_gold_*.exe'

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
WINETARGET="GOG Games/Sacred Gold"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/GOG Games/Sacred Gold/save"

## Notes shown before program is executed
PRERUN="
Wine Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=13697
"

find_and_run_executable "$@"
