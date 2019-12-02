#!/bin/bash

## Location of the executable:
PROGDIR="Duskers"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_duskers_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/Misfits Attic/Duskers"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

