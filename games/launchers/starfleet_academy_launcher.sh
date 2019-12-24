#!/bin/bash

## Location of the executable:
PROGDIR="Starfleet Academy"
LAUNCH="sfa.exe"

## Location of the installer:
INSTDIR="GOG/Star Trek"
INSTNAME='setup_starfleet_academy_*.exe'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
WINETARGET="GOG Games/Star Trek - Starfleet Academy"
## INSTTRICKS="allcodecs dotnet40"

## Installation post-processing:
INSTSAVEDIR="$HOME/Programs/$PROGDIR/savegame"

INSTICON="$PROGDIR.jpg"

## Notes:
PRERUN="
Fairly tepid performance in wine. May require a joystick to play effectively.

WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=34953

"

find_and_run_executable "$@"
