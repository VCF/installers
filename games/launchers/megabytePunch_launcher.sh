#!/bin/bash

## Location of the executable:
PROGDIR="Megabyte Punch"
LAUNCH="MegabytePunch.x86"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='MegabytePunch_linux_*.tar.gz'
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Rename the default install directory to something else:
## INSTRENAME='LegendofDungeon-Linux/'$PROGDIR
## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Define a parent directory for unpacking archives:
UNPACKDIR="$PROGDIR"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Reptile/Megabyte Punch"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

#function INSTFUNCTION {
#    ## Executable needs to be set on main program
#    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
#}

find_and_run_executable "$@"
