#!/bin/bash

## Location of the executable:
PROGDIR="Supreme Commander"
LAUNCH="bin/SupremeCommander.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_supreme_commander_1*.exe'

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
INSTSAVEDIR="drive_c/users/$USER/Local Settings/Application Data/Gas Powered Games/SupremeCommander/savegames"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Custom function to run after installation:
function INSTFUNCTION {
    addDLC 'setup_supreme_commander_forged_alliance_*.exe'
}

find_and_run_executable "$@"
