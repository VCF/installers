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

PRERUN="
Port alterations that might be needed:

  ## https://arduino.stackexchange.com/a/21219
  sudo usermod -a -G dialout $USER # Associate yourself with dialout group
  sudo chmod a+rw /dev/ttyACM0     # Make the TTY port read/write

"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
