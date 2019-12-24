#!/bin/bash

PROGDIR="RimWorld"
LAUNCH="start_RimWorld.sh"

## Location of the installer on your file system:
INSTDIR="Indie/$PROGDIR"
INSTNAME='RimWorld*Linux.zip'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
