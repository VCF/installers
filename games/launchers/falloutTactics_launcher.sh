#!/bin/bash

## Location of the executable:
PROGDIR="Fallout Tactics"
LAUNCH="BOS.exe"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_fallout_tactics.exe'

## Wine configuration:
wineBits="32"
WINEPREFIX="$HOME/Wine$wineBits"
WINEARCH="win$wineBits"
APTPACKAGES="winetricks"
INSTTRICKS="directplay"

## Installation post-processing:
WINETARGET="Program Files/GOG.com/Fallout Tactics"
INSTSAVEDIR="drive_c/Program Files/GOG.com/Fallout Tactics/core/user"
INSTICON="$PROGDIR.png"

## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=810
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

