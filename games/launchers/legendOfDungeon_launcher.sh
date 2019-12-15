#!/bin/bash

## Location of the executable:
PROGDIR="Legend of Dungeon"
LAUNCH="LegendofDungeon.x86_64"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='LegendofDungeon_linux_*.zip'
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Rename the default install directory to something else:
INSTRENAME='LegendofDungeon-Linux/'$PROGDIR
## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Define a parent directory for unpacking archives:
## UNPACKDIR="$PROGDIR"
## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/RobotLovesKitty/Legend of Dungeon"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

#function INSTFUNCTION {
#    ## Executable needs to be set on main program
#    chmod u+x "$GAMEDIR/$PROGDIR/$LAUNCH"
#}

find_and_run_executable "$@"
