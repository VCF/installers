#!/bin/bash

## Location of the executable:
PROGDIR="Rage of Mages"
LAUNCH="rom.exe"
## Arguments to pass to the executable when running:
LAUNCHARGS="-1024"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_rage_of_mages_*.exe'

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
WINETARGET="GOG Games/Rage of Mages"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
##   -> Saves are dumped right into the program directory

## Notes shown before program is executed
PRERUN="
Wine Platinum
  https://lutris.net/games/rage-of-mages/
"

find_and_run_executable "$@"
