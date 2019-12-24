#!/bin/bash

## Location of the executable:
PROGDIR="Paradigm"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_paradigm_*.sh'
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Rename the default install directory to something else:
## INSTRENAME='LegendofDungeon-Linux/'$PROGDIR
## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Define a parent directory for unpacking archives:
## UNPACKDIR="$PROGDIR"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Jacob_Janerka/Paradigm"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

#function INSTFUNCTION {
#
#}

find_and_run_executable "$@"
