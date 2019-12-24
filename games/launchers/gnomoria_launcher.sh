#!/bin/bash

PROGDIR="Gnomoria"
LAUNCH="Gnomoria.bin.x86_64"

INSTDIR="GOG/$PROGDIR"
INSTNAME='gog_gnomoria_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
