#!/bin/bash

## Location of the executable:
PROGDIR="UFO Aftershock"
LAUNCH="UFO.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_ufo_aftershock.exe'

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
WINETARGET="Program Files/GOG.com/UFO Aftershock"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Profiles"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=5914
"

find_and_run_executable "$@"
