#!/bin/bash

PROGDIR="Xenonauts"
LAUNCH="Xenonauts.bin.x86"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_xenonauts_*.bin'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
