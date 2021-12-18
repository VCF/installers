#!/bin/bash

## Location of the executable:
PROGDIR="Far - Lone Sails"
LAUNCH="FarLoneSails.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_far_lone_sails_1.21_(33080).exe'

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
WINETARGET="GOG Games/FAR Lone Sails"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/tilfordc/AppData/LocalLow/Okomotive/FarLoneSails"


## Notes shown before program is executed
PRERUN="
https://appdb.winehq.org/objectManager.php?sClass=version&iId=36986
Wine 64-bit
  Landing page was blank on low-spec integrated graphics system
"

find_and_run_executable "$@"
