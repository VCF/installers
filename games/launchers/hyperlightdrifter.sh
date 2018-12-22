#!/bin/bash

## Location of the executable:
PROGDIR="Hyper Light Drifter"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_hyper_light_drifter_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/HyperLightDrifter"
INSTICON="$PROGDIR.png"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
