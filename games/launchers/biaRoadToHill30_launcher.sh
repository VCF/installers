#!/bin/bash

## Location of the executable:
PROGDIR="BiA Road to Hill 30"
LAUNCH="bia.exe"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="System"

## Location of the installer on your file system:
INSTDIR="GOG/Brothers in Arms"
INSTNAME='setup_brothers_in_arms_road_to_hill_30tm_*.exe'

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
WINETARGET="GOG Games/Brothers in Arms - Road to Hill 30"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/tilfordc/Application Data/Gearbox Software/Brothers In Arms"

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=4191
"

find_and_run_executable "$@"
