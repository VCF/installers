#!/bin/bash

## Location of the executable:
PROGDIR="Fallout 2"
LAUNCH="fallout2.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_fallout_2.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
APTPACKAGES="winetricks"
INSTTRICKS="directplay"

## Installation post-processing:
WINETARGET="Program Files/GOG.com/Fallout 2"
INSTSAVEDIR="drive_c/Program Files/GOG.com/Fallout 2/data/SAVEGAME"
INSTICON="$PROGDIR.png"

## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=27466
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

