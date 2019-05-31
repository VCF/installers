#!/bin/bash

## Location of the executable:
PROGDIR="Minecraft"
LAUNCH="minecraft.jar"
JAVACMD="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"
## Location of the installer:
APTPACKAGES="openjdk-8-jre"
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

## Minecraft apparently needs JRE 8
##   https://askubuntu.com/a/1030255
##   I can confirm it failed with 11, but worked for 8 (Ubuntu 18.04.2 LTS)
