#!/bin/bash

## Location of the executable:
PROGDIR="Cataclysm DDA"
LAUNCH="cataclysm-launcher"
LAUNCHCHK="cataclysm-tiles"
## Location of the installer:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='cdda-linux-with-graphics-and-sounds-x64-*.tar.gz'
## Installation post-processing:
INSTICON="$PROGDIR.jpg"
INSTRENAME='cataclysmdda-*/'"$PROGDIR"
APTPACKAGES="
libsdl2-dev
libsdl2-ttf-dev
libsdl2-image-dev
libsdl2-mixer-dev
libsdl2-mixer-2.0-0
libsdl2-ttf-2.0-0
libsdl2-image-2.0-0
libfreetype6-dev
build-essential"
INSTSAVEDIR="$HOME/Programs/$PROGDIR/save"

PRERUN="
Cataclysm - Dark Days Ahead
* https://cataclysmdda.org/
* https://github.com/CleverRaven/Cataclysm-DDA/
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
