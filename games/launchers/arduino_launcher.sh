#!/bin/bash

## IDE for Arduino
##   Even on Mint 18.3 in 2018 the Mint repo was pretty far behind:
##   https://www.arduino.cc/en/main/software

## Location of the executable:
PROGDIR="Arduino"
LAUNCH="arduino"
## Location of the installer:
INSTDIR="OpenSource/Arduino"
INSTNAME='arduino-*-linux64.tar.xz'
## Installation post-processing:
INSTRENAME='arduino-*/'$PROGDIR
INSTICON="Arduino.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
