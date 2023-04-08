#!/bin/bash

## Location of the executable:
PROGDIR="Grim Dawn"
LAUNCH="Grim Dawn.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_grim_dawn_1*.exe'
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Wine configuration:
wineBits="32"
export WINEPREFIX="$HOME/Wine$wineBits"
export WINEARCH="win$wineBits"

## Installation post-processing:
## Capitalization may vary:
WINETARGET="GOG Games/Grim Dawn"
LAUNCHARGS="/d3d9" # WineHQ says "Direct X 11 doesn't work"
INSTSAVEDIR="$HOME/Documents/My Games/Grim Dawn"

## Custom function to run after installation:
function INSTFUNCTION {
    echo "Installing DLCs"
    addDLC 'setup_grim_dawn_-_ashes_of_malmouth_*.exe'
    addDLC 'setup_grim_dawn_-_crucible_*.exe'
    addDLC 'setup_grim_dawn_-_forgotten_gods_*.exe'
}

## Notes:
PRERUN="
WineHQ Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=36505

"

find_and_run_executable "$@"
