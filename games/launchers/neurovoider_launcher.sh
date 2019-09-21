#!/bin/bash

## Location of the executable:
PROGDIR="NeuroVoider"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/Neurovoider"
INSTNAME='neurovoider_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/.neurovoider"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
