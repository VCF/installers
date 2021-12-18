#!/bin/bash

## Location of the executable:
PROGDIR="Arcanum"
LAUNCH="Arcanum.exe"
## Arguments to pass to the executable when running:
LAUNCHARGS="-no3d -doublebuffer"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_arcanum.exe'

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
WINETARGET="Program Files/GOG.com/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/data"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Gold:
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=22375
"

find_and_run_executable "$@"
