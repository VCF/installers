#!/bin/bash

## Location of the executable:
PROGDIR="Freedom Force"
LAUNCH="fforce.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_freedom_force_1*.exe'

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
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Data/SaveGames"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Gold/Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=8858

Note: Changing resolution causes sound to be set to 'No Sound'
Go to the Audio settings tab, and choose 'DirectSound 3D Software Emulation'
"

find_and_run_executable "$@"
