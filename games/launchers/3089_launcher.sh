#!/bin/bash

## Location of the executable:
PROGDIR="3089"
LAUNCH="3089.jar"
## Needs Java 8:
JAVACMD="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"

## Location of the installer on your file system:
INSTDIR="IndieGameStand/$PROGDIR"
INSTNAME='3089FullInstaller_*.jar'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='openjdk-8-jre'

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/3089"

## Notes shown before the installer program runs
PREINST="
When asked for the installation path, please specify:
     $GAMEDIR/$PROGDIR
Uncheck the 'Make Shortcut' option when it finishes.
"

## Notes shown before program is executed
#PRERUN="
#  Not entirely stable ...
#"

find_and_run_executable "$@"
