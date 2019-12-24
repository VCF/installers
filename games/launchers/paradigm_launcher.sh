#!/bin/bash

## Location of the executable:
PROGDIR="Paradigm"
LAUNCH="start.sh"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_paradigm_*.sh'

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"
INSTSAVEDIR="$HOME/.local/share/Jacob_Janerka/Paradigm"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
