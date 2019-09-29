#!/bin/bash

## Location of the executable:
PROGDIR="Project Zomboid"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/${PROGDIR}s"
INSTNAME='project_zomboid_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/Zomboid/Saves"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
