#!/bin/bash

## Location of the executable:
PROGDIR="Desperados Wanted Dead or Alive"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Desperados"
INSTNAME='desperados_wanted_dead_or_alive_en_gog_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Desperados.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/.local/share/THQNordic/Desperados"
## Flag to use if backup should use rsync rather than tar/gzip:
DORSYNC="yes"

## Notes shown before program is executed
#PRERUN="
#  Any message you want the program to display before running
#"

find_and_run_executable "$@"
