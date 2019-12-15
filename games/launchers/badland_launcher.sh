#!/bin/bash

## Location of the executable:
PROGDIR="Badland"
LAUNCH="badland"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='BADLAND_LINUX.tar.gz'
## Installation post-processing:
INSTICON="$PROGDIR.png"
UNPACKDIR="$PROGDIR"
APTPACKAGES="libcurl3"
INSTSAVEDIR="$HOME/.BADLAND"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
