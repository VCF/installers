#!/bin/bash

## Location of the executable:
PROGDIR="Terraria"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/Terraria"
INSTNAME='terraria_v1_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.local/share/Terraria"
INSTICON="Terraria.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
