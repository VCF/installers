#!/bin/bash

## Location of the executable:
PROGDIR="Slay the Spire"
LAUNCH="desktop-1.0.jar"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="game"
## JAVA JRE - installed with the game
JAVACMD="jre/bin/java"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='slay_the_spire_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/$PROGSUBDIR/saves"

## Custom function to run after installation:
function INSTFUNCTION {
    ## If the jar file is executable it confuses the launcher script
    chmod 0666 "$GAMEDIR/$PROGDIR/$PROGSUBDIR/$LAUNCH"
}

find_and_run_executable "$@"
