#!/bin/bash

## Location of the executable:
PROGDIR="ScourgeBringer"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Scourgebringer"
INSTNAME='scourgebringer_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.jpg"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.scourgebringer"

find_and_run_executable "$@"
