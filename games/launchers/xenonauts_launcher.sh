#!/bin/bash

## Location of the executable:
PROGDIR="Xenonauts"
LAUNCH="start.sh"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='xenonauts_en_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/Goldhawk Interactive/Xenonauts"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

find_and_run_executable "$@"
