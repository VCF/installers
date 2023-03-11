#!/bin/bash

## Location of the executable:
PROGDIR="Dysmantle"
LAUNCH="DYSMANTLE.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_dysmantle_*.exe'

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
WINETARGET="GOG Games/DYSMANTLE"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Application Data/10tons/DYSMANTLE/"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Platinum
    https://www.gog.com/en/game/dysmantle
    https://store.steampowered.com/app/846770/DYSMANTLE/
    https://www.protondb.com/app/846770
"

find_and_run_executable "$@"
