#!/bin/bash

## Location of the executable:
PROGDIR="Space Pirates And Zombies 2"
ALTNAME="Space Pirates and Zombies 2"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$ALTNAME"
INSTNAME='space_pirates_and_zombies_2_en_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$ALTNAME.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/MinMax Games/SPAZ 2"

find_and_run_executable "$@"
