#!/bin/bash

## Location of the executable:
PROGDIR="Arduino"
LAUNCH="arduino"
## Location of the installer:
INSTDIR="OpenSource/Arduino"
INSTNAME='arduino-*-linux64.tar.xz'
## Installation post-processing:
INSTRENAME='arduino-*/'$PROGDIR

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
