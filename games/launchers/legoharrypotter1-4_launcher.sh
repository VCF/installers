#!/bin/bash

### Shares installer with Sentinels sequel

## Location of the executable:
PROGDIR="LegoHarryPotter1-4"
#PROGSUBDIR="Silent Storm"
LAUNCH="LEGOHarryPotter.exe"
## Location of the installer:
INSTDIR="GOG/Lego Harry Potter"
INSTNAME='setup_lego_harry_potter_1-4_*.exe'
## Installation post-processing:
## Capitalization may vary:
WINETARGET="GOG Games/LEGO Harry Potter 1-4"
# INSTSAVEDIR="$PROGSUBDIR/save"
INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Platinum
  https://appdb.winehq.org/objectManager.php?sClass=application&iId=11718

  Supposedly. In my hands, it's Garbage - graphics are massively messed up,
  psychadelic blocks of color.

  Failed in both Wine1.6 and Wine3.0
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
