#!/bin/bash

## Location of the executable:
PROGDIR="Apotheon"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_apotheon_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.local/share/Apotheon"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

