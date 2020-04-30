#!/bin/bash

## Location of the executable:
PROGDIR="StarCrawlers"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='starcrawlers_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Juggernaut Games/StarCrawlers"


find_and_run_executable "$@"
