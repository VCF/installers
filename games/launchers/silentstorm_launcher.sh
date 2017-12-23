#!/bin/bash

### Shares installer with Sentinels sequel

## Location of the executable:
PROGDIR="SilentStorm"
WINESUBDIR="Silent Storm"
LAUNCH="game.exe"
## Location of the installer:
INSTDIR="GOG/Silent Storm"
INSTNAME='setup_silent_storm_*.exe'
## Installation post-processing:
WINETARGET="Program Files (x86)/GOG.com/Silent Storm GOLD"
INSTSAVEDIR="$WINESUBDIR/save"
INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=4304
"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
