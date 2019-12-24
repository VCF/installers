#!/bin/bash

## Location of the executable:
PROGDIR="Craft the World"
LAUNCH="CraftWorld.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_craft_the_world_*.exe'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
WINETARGET="GOG Games/Craft The World"

## Installation post-processing:
INSTSAVEDIR="drive_c/users/$USER/Application Data/dekovir/crafttheworld/saves"

INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=16032
"

find_and_run_executable "$@"
