#!/bin/bash

## Location of the executable:
PROGDIR="Fell Seal Arbiters Mark"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Fell Seal"
INSTNAME='fell_seal_arbiter_s_mark_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="Fell Seal.png"

## Location of the programs save files / config:
INSTSAVEDIR="$HOME/Fell Seal"

find_and_run_executable "$@"
