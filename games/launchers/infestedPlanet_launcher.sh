#!/bin/bash

## Location of the executable:
PROGDIR="Infested Planet"
LAUNCH="InfestedPlanet.exe"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_infested_planet_*.exe'

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
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Local Settings/Application Data/Rocket Bear Games/$PROGDIR"

## Notes shown before program is executed
PRERUN="
Essentially Wine Gold
  Could not get full screen to work, otherwise flawless
"

find_and_run_executable "$@"
