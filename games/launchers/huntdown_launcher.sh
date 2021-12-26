#!/bin/bash

## Location of the executable:
PROGDIR="HUNTDOWN"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Huntdown"
INSTNAME='huntdown_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Huntdown.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.config/unity3d/Coffee Stain Publishing/Huntdown"

find_and_run_executable "$@"
