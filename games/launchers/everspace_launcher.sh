#!/bin/bash

## Linux native
## https://www.gog.com/game/everspace

## Location of the executable:
PROGDIR="Everspace"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='everspace_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTRENAME='EVERSPACE/'$PROGDIR
INSTSAVEDIR="$HOME/.config/Epic/RSG/Saved"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
