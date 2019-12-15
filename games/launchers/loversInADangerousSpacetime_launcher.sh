#!/bin/bash

## Location of the executable:
PROGDIR="Lovers in a Dangerous Spacetime"
LAUNCH="LoversInADangerousSpacetime.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='LoversInADangerousSpacetime-*_Linux.zip'
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Rename the default install directory to something else:
## INSTRENAME='LegendofDungeon-Linux/'$PROGDIR
## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Define a parent directory for unpacking archives:
UNPACKDIR="$PROGDIR"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/LoversInADangerousSpacetime"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

#function INSTFUNCTION {
#    ## Executable needs to be set on main program
#    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
#}

find_and_run_executable "$@"
