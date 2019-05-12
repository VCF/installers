#!/bin/bash

## Location of the executable:
PROGDIR="Divinity Original Sin"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='divinity_original_sin_enhanced_edition_en_*.sh'
## Installation post-processing:
#INSTSAVEDIR="$HOME/.FarSky/save"
INSTRENAME="$PROGDIR Enhanced Edition/$PROGDIR"
INSTICON="$PROGDIR.png"
## Notes:

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

msg "$FgRed" "
Requires OpenGL 4.0
  ... and probably proprietary Nvidia drivers
"

find_and_run_executable "$@"
