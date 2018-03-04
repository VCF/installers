#!/bin/bash

## Location of the executable:
PROGDIR="FarSky"
LAUNCH="FarSky.sh"
## Location of the installer:
INSTDIR="Humble Indie Bundle/Far Sky"
INSTNAME='FarSkyrelease.tar'
## Installation post-processing:
INSTSAVEDIR="$HOME/.FarSky/save"
INSTICON="$PROGDIR.png"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
