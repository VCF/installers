#!/bin/bash

## Location of the executable:
PROGDIR="Deep Sky Derelicts"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='deep_sky_derelicts_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/Snowhound/Deep Sky Derelicts"
INSTICON="$PROGDIR.jpg"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
