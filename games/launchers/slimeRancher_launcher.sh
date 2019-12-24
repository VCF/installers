#!/bin/bash

## Location of the executable:
PROGDIR="Slime Rancher"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='slime_rancher_*.sh'
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Rename the default install directory to something else:
## INSTRENAME='LegendofDungeon-Linux/'$PROGDIR
## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Define a parent directory for unpacking archives:
## UNPACKDIR="$PROGDIR"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Monomi Park/Slime Rancher"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

#function INSTFUNCTION {
#
#}

find_and_run_executable "$@"
