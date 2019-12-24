#!/bin/bash

PROGDIR="Tales Of Maj Eyal"
LAUNCH="start.sh"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='tales_of_maj_eyal_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
