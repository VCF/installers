#!/bin/bash

## Location of the executable:
PROGDIR="Lethal League"
LAUNCH="LethalLeague"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Lethal_League.tar.gz'
## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
## Rename the default install directory to something else:
## INSTRENAME='LegendofDungeon-Linux/'$PROGDIR
## Specify any required APT packages:
## APTPACKAGES='libsdl2-mixer-2.0-0'
## Define a parent directory for unpacking archives:
UNPACKDIR="$PROGDIR"
## Location of the programs save files / config:
INSTSAVEDIR="NONE" # Does not appear to be a save directory?

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Set loca library path:

LL_LIBS="$GAMEDIR/$PROGDIR/binaries"
## export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:"

function INSTFUNCTION {
    ## Library is misnamed
    curdir="$(pwd)"
    cd "$LL_LIBS"
    ln -s "libGLEW.so.1.10.0" "libGLEW.so.1.10"
    cd "$curdir"
}

find_and_run_executable "$@"
