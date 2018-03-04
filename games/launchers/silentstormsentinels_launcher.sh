#!/bin/bash

### Shares installer with original Silent Storm

## Location of the executable:
PROGDIR="SilentStormSentinels"
PROGSUBDIR="Silent Storm Sentinels"
LAUNCH="Sentinels.exe"
## Location of the installer:
INSTDIR="GOG/Silent Storm"
INSTNAME='setup_silent_storm_*.exe'
## Installation post-processing:
WINETARGET="Program Files (x86)/GOG.com/Silent Storm GOLD"
INSTSAVEDIR="$PROGSUBDIR/save"
DORSYNC="yes"
INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=7522
"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
