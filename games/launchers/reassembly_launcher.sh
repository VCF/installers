#!/bin/bash

PROGDIR="Reassembly"
LAUNCH="linux/ReassemblyRelease64"

## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Reassembly_*.tar.gz'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
