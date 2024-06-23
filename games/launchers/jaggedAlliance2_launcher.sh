#!/bin/bash

## Location of the executable:
SNAME="Jagged Alliance 2"
PROGDIR="$SNAME"
LAUNCH="ja2.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$SNAME"
INSTNAME='setup_jagged_alliance_2_1*.exe'

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
WINETARGET="GOG Games/Jagged Alliance 2"

## Filename of launcher icon (looks in default folders):
INSTICON="$SNAME.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/SavedGames"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Silver
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=40397
Leaving program by Alt-Tab can cause it to become confused.
  -> Save and restart
"

find_and_run_executable "$@"
