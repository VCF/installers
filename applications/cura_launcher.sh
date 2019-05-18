#!/bin/bash

## Location of the executable:
PROGDIR="Cura"
LAUNCH="Cura.AppImage"
## Location of the installer:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='Ultimaker_Cura-*.AppImage'
## Installation post-processing:
INSTICON="$PROGDIR.png"
## This is not really a 'save' directory, but rather holds the Cura settings
INSTSAVEDIR="$HOME/.config/cura"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
