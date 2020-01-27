#!/bin/bash

### Shares installer with Sentinels sequel

## Location of the executable:
PROGDIR="Silent Storm"
PROGSUBDIR="Silent Storm"
LAUNCH="game.exe"
## Location of the installer:
INSTDIR="GOG/Silent Storm"
INSTNAME='setup_silent_storm_*.exe'

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="32"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="Program Files/GOG.com/Silent Storm GOLD"

INSTSAVEDIR="$PROGSUBDIR/save"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"
## Filename of launcher icon (looks in default folders):
INSTICON="SilentStorm.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=4304
"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
