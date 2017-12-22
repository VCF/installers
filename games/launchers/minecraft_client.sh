#!/bin/bash

## Location of the executable:
PROGDIR="Minecraft"
LAUNCH="minecraft.jar"
## Location of the installer:
INSTDIR="/abyss/Common/$PROGDIR/Executable"
INSTNAME="$LAUNCH"
INSTCOPY=true # Installation is just a copy
INSTHELP="To update, visit: https://minecraft.net/download
  Save with versioned filename, then update symlink to $LAUNCH
"
## Installation post-processing:
INSTSAVEDIR="$HOME/.minecraft/saves"
INSTICON="minecraft_logo1.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
