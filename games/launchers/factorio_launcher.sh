#!/bin/bash

## Location of the executable:
PROGDIR="Factorio"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/Factorio"
INSTNAME='factorio_en_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/Programs/Factorio/game/saves"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
