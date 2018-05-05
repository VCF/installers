#!/bin/bash

## Location of the executable:
PROGDIR="AgeOfDecadence"
LAUNCH="AoD.exe"

## Location of the installer:
INSTDIR="GOG/Age of Decadence"
INSTNAME='setup_the_age_of_decadence_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
INSTTRICKS="d3dcompiler_43"

## Installation post-processing:
## Capitalization may vary:
WINETARGET="GOG Games/The Age of Decadence"
INSTSAVEDIR="drive_c/users/$USER/My Documents/My Games/Age Of Decadence"

INSTICON="$PROGDIR.jpg"
## Notes:
PRERUN="
WineHQ Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=34401

"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
