#!/bin/bash

## Location of the executable:
PROGDIR="Sil-Q"
LAUNCH="sil"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='sil-q-*.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='sil-q-*/'$PROGDIR

## Specify any required APT packages:
APTPACKAGES='libncurses5-dev'

## Custom function to run after installation:
function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR/src"
    msg "$FgMagenta" "
Compiling $PROGDIR in '$(pwd)'
"
    make -f Makefile.std install
}

find_and_run_executable "$@"
