#!/bin/bash

## Location of the executable:
PROGDIR="Cataclysm DDA"
LAUNCH="cataclysm-launcher"
## Location of the installer:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='cataclysmdda-*-Linux_x64-Tiles-*.tar.gz'
## Installation post-processing:
INSTICON="$PROGDIR.jpg"
INSTRENAME='cataclysmdda-*/'"$PROGDIR"
APTPACKAGES="
libsdl2-dev
libsdl2-ttf-dev
libsdl2-image-dev
libsdl2-mixer-dev
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
