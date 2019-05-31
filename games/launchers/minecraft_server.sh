#!/bin/bash

## Location of the executable:
PROGDIR="Minecraft Server"
LAUNCH="server.jar"
JAVACMD="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"
## Location of the installer:
INSTCOPY=true # Installation is just a copy
INSTDIR="/abyss/Common/Minecraft/Executable"
INSTNAME='minecraft_server.*.jar'
INSTHELP="To update, visit:
  https://www.minecraft.net/en-us/download/server/
"
## Installation post-processing:
# INSTSAVEDIR="$HOME/Programs/$PROGDIR/worlds"
INSTICON="$PROGDIR.png"
## UNPACKDIR="$PROGDIR"
NOREDIRECT="TRUE"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

msg "$FgGreen" "

Settings for your server are in:
  $GAMEDIR/$PROGDIR/server.properties

"

function INSTFUNCTION {
    echo "# Blah blau EULA
eula=TRUE
" > "$GAMEDIR/$PROGDIR/eula.txt"
    
}

find_and_run_executable "$@"

