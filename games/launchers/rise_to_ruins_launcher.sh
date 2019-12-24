#!/bin/bash

PROGDIR="Rise to Ruins"
LAUNCH="RtR.sh"

## Location of the installer on your file system:
INSTDIR="IndieGameStand/$PROGDIR"
INSTNAME='Rise to Ruins i25.zip'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
