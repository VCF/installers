#!/bin/bash

## Location of the executable:
PROGDIR="Basingstoke"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/Basingstoke"
INSTNAME='basingstoke_en_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/Puppygames/Basingstoke"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

PRERUN="
* Cashed HARD on first run (required system reboot) but ran subsequently
* Relatively high hardware requirements
"

find_and_run_executable "$@"

