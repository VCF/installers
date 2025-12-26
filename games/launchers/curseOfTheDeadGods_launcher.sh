#!/bin/bash

## Location of the executable:
PROGDIR="Curse of the Dead Gods"
LAUNCH="Curse of the Dead Gods.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_curse_of_the_dead_gods_*.exe'

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
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Saved Games/Curse of the Dead Gods"

## Notes shown before program is executed
PRERUN="
Proton Gold
  https://www.protondb.com/app/1123770?device=pc
"

find_and_run_executable "$@"
