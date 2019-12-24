#!/bin/bash

PROGDIR="TheSpatials"
LAUNCH="run-thespatials.sh";

## Location of the installer on your file system:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='TheSpatialsLinux.tar.gz'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
