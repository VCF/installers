#!/bin/bash

## Location of the executable:
PROGDIR="Pharaonic"
LAUNCH="start.sh"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='pharaonic_en_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Milkstone Studios/Pharaonic"

find_and_run_executable "$@"
