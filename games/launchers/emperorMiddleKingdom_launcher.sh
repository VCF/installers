#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Location of the executable:
PROGDIR="Emperor - Rise of the Middle Kingdom"
LAUNCH="Emperor.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_emperor_rise_of_the_middle_kingdom_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
# INSTTRICKS="directplay"

## Installation post-processing:
WINETARGET="GOG Games/Emperor - Rise of the Middle Kingdom"
INSTSAVEDIR="$GAMEDIR/$PROGDIR/Save"
INSTICON="$PROGDIR.png"

## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=3989
"

find_and_run_executable "$@"

