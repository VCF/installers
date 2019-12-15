#!/bin/bash

## Location of the executable:
PROGDIR="Asura"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='asura_en_*.sh'
## Installation post-processing:
INSTSAVEDIR="$HOME/.config/unity3d/OgreHeadStudio/Asura"
INSTICON="$PROGDIR.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

