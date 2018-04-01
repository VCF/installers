#!/bin/bash

## Location of the executable:
PROGDIR="Balrum"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='balrum_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/Programs/$PROGDIR/game/files/saves"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
