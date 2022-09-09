#!/bin/bash

## Location of the executable:
PROGDIR="Might and Magic 7"
## What GOG normally launches, but will background the main exe:
# LAUNCH="MM7.exe" 
LAUNCH="MM7-Rel.exe"

## Location of the installer on your file system:
INSTDIR="GOG/Heros of Might and Magic/$PROGDIR"
INSTNAME='setup_might_and_magic_7_*.exe'

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
WINETARGET="GOG Games/Might and Magic 7"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Saves"

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=5696
"

find_and_run_executable "$@"
