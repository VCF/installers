#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Location of the executable:
PROGDIR="SanctuaryRPG"
LAUNCH="SanctuaryRPG.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_sanctuary_rpg_black_*.exe'

## Wine configuration:
wineBits="32"
export WINEPREFIX="$HOME/Wine$wineBits"
export WINEARCH="win$wineBits"
WINETARGET="GOG Games/Sanctuary RPG - Black Edition"

## Installation post-processing:
INSTSAVEDIR="$HOME/Programs/SanctuaryRPG/Data"

INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=30888
"

find_and_run_executable "$@"
