#!/bin/bash

## Location of the executable:
PROGDIR="Heroes Of Loot"
LAUNCH="heroesofloot.jar"
## Needs Java 8:
JAVACMD="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"

## Location of the installer on your file system:
INSTDIR="IndieGameStand/$PROGDIR"
INSTNAME='heroesofloot_linux*.zip'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Rename the default install directory to something else:
INSTRENAME='linux/'$PROGDIR

## Specify any required APT packages:
APTPACKAGES='openjdk-8-jre'

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.prefs"
## ... seems suspiciously generic. Only saw files from this program in
## that folder, though.

find_and_run_executable "$@"
