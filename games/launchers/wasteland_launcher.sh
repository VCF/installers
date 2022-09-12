#!/bin/bash

## Location of the executable:
PROGDIR="Wasteland 1 The Original Classic"
SHORTDIR="Wasteland"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/$SHORTDIR"
INSTNAME='gog_wasteland_1_the_original_classic_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$SHORTDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.wasteland"

find_and_run_executable "$@"
