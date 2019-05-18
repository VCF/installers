#!/bin/bash

## Location of the executable:
PROGDIR="OpenSCAD"
LAUNCH="$PROGDIR.AppImage"
## Location of the installer:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='OpenSCAD-*-x86_64.AppImage'
## Installation post-processing:
INSTICON="$PROGDIR.png"
## This is not really a 'save' directory, but rather holds the OpenSCAD settings
INSTSAVEDIR="$HOME/.config/OpenSCAD"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
