#!/bin/bash

### Shares installer with Sentinels sequel

## Location of the executable:
PROGDIR="SotS The Pit"
LAUNCH="ThePit.exe"

## Location of the installer:
INSTDIR="GOG/SOTS The Pit"
INSTNAME='setup_sots_the_pit_*.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
## INSTTRICKS="dotnet40 xna40"

## Installation post-processing:
WINETARGET="GOG Games/Sword of The Stars - The Pit"
INSTSAVEDIR="drive_c/users/$USER/Application Data/Sword of the Stars - The Pit"
INSTICON="$PROGDIR.png"

## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=32195
"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
