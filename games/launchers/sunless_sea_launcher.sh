#!/bin/bash

PROGDIR="Sunless Sea"
LAUNCH="Sunless Sea.x86_64"

## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='Sunless_Sea_Setup_*LINUX.zip'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
