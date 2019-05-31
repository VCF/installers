#!/bin/bash

## Location of the executable:
PROGDIR="Bedrock Server"
LAUNCH="bedrock_server"
## Location of the installer:
INSTDIR="/abyss/Common/Minecraft/Executable"
INSTNAME='bedrock-server-*.zip'
INSTHELP="To update, visit:
  https://www.minecraft.net/en-us/download/server/bedrock/
"
## Installation post-processing:
INSTSAVEDIR="$HOME/Programs/$PROGDIR/worlds"
INSTICON="$PROGDIR.png"
UNPACKDIR="$PROGDIR"
NOREDIRECT="TRUE"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

msg "$FgGreen" "

Settings for your server are in:
  $GAMEDIR/$PROGDIR/server.properties

"

find_and_run_executable "$@"

