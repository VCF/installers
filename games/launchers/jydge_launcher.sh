#!/bin/bash

## Location of the executable:
PROGDIR="JYDGE"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='jydge_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Jydge.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/10tons/$PROGDIR"

find_and_run_executable "$@"
