#!/bin/bash

## Location of the executable:
PROGDIR="Rebuild 3"
LAUNCH="Rebuild3.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_rebuild_3_gangs_of_deadsville_*.exe'

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
WINETARGET="GOG Games/Rebuild 3 Gangs of Deadsville"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Application Data/com.sarahnorthway.rebuild3"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Notes shown before program is executed
PRERUN="
Proton Gold:
  https://www.protondb.com/app/257170
"

find_and_run_executable "$@"
