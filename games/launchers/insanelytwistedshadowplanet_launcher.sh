#!/bin/bash

## Location of the executable:
PROGDIR="Insanely Twisted Shadow Planet"
LAUNCH="fcengine-bin"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='InsanelyTwistedShadowPlanet_Linux_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/.local/share/Fuelcell/Insanely Twisted Shadow Planet"

## PRERUN=""

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
