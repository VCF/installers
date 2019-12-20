#!/bin/bash

### Shares installer with Sentinels sequel

## Location of the executable:
PROGDIR="Fallout"
LAUNCH="falloutw.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_fallout_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
## INSTTRICKS="dotnet40 xna40"

## Installation post-processing:
WINETARGET="GOG Games/Fallout"
INSTSAVEDIR="drive_c/GOG Games/Fallout/DATA/SAVEGAME"
INSTICON="$PROGDIR.png"

## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=25713
"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

