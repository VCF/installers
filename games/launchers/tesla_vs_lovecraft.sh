#!/bin/bash

## Location of the executable:
PROGDIR="Tesla vs Lovecraft"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='tesla_vs_lovecraft_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/.local/share/10tons/Tesla_vs_Lovecraft/profiles"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
