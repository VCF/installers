#!/bin/bash

## Location of the executable:
PROGDIR="SteamWorld Dig 2"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Steam World Dig 2"
INSTNAME='steamworld_dig_2_en_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/SteamWorld Dig 2"

find_and_run_executable "$@"
