#!/bin/bash

PROGDIR="Nuclear Throne"
LAUNCH="runner"

## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='nuclearthrone-linux.zip'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
