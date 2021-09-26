#!/bin/bash

## Location of the executable:
PROGDIR="STALKER - Clear Sky"
LAUNCH="bin/xrEngine.exe"

## Location of the installer on your file system:
INSTDIR="GOG/S.T.A.L.K.E.R."
INSTNAME='setup_stalker_cs_*.exe'

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
WINETARGET="GOG Games/S.T.A.L.K.E.R. Clear Sky"
## Any winetricks that might be needed:
INSTTRICKS="d3dx9"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Documents/Stalker-STCS/savedgames"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
PRERUN="
Wine Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=35649
  https://www.gog.com/game/stalker_clear_sky
"

find_and_run_executable "$@"
