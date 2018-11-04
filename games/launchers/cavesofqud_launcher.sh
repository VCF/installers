#!/bin/bash

## Location of the executable:
PROGDIR="Caves of Qud"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/Caves of Qud"
INSTNAME='caves_of_qud_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/Freehold Games/CavesOfQud/Saves"
INSTICON="$PROGDIR.jpg"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
