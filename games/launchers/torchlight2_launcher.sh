#!/bin/bash

PROGDIR="Torchlight"
LAUNCH="Torchlight2.bin.x86_64"

## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Torchlight2-linux-*.sh'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
