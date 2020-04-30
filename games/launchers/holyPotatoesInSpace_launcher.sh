#!/bin/bash

## Location of the executable:
PROGDIR="Holy Potatoes Were in Space"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='holy_potatoes_we_re_in_space_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Daedalic Entertainment GmbH/HPWIS"

find_and_run_executable "$@"
