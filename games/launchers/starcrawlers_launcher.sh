#!/bin/bash

## Location of the executable:
PROGDIR="StarCrawlers"
LAUNCH="DID NOT RECORD"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='starcrawlers_*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
