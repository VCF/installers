#!/bin/bash

## Location of the executable:
PROGDIR="Door Kickers - Action Squad"
LAUNCH="ActionSquad.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_door_kickers_action_squad_*.exe'

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
WINETARGET="GOG Games/ActionSquad"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Local Settings/Application Data/KillHouseGames/ActionSquad"

## Notes shown before program is executed
PRERUN="
https://appdb.winehq.org/objectManager.php?sClass=version&iId=38671
"

find_and_run_executable "$@"
