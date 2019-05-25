#!/bin/bash

## Location of the executable:
PROGDIR="UbuntuSleep"
LAUNCH="ubuntuSleep.sh"
## Location of the installer:
INSTNAME='ubuntuSleep.sh'
INSTCOPY="1"
## Installation post-processing:
INSTICON="RedPauseButton.png"

NOTINTERM="1"  # Don't bother with an intermediate shell

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
