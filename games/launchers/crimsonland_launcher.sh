#!/bin/bash

## Location of the executable:
PROGDIR="Crimsonland"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='crimsonland_en_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/.local/share/10tons/Crimsonland"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
