#!/bin/bash

## Location of the executable:
PROGDIR="Metal Fatigue"
LAUNCH="MFatigue.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_metal_fatigue_*.exe'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
WINETARGET="GOG Games/Metal Fatigue"

## Installation post-processing:
INSTSAVEDIR="drive_c/GOG Games/Metal Fatigue/Save"

INSTICON="$PROGDIR.jpg"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=37034
"

find_and_run_executable "$@"
