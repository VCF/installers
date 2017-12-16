#!/bin/bash

## Location of the executable:
PROGDIR="Barony"
LAUNCH="barony.x86_64"
## Location of the installer:
INSTDIR="IndieGameStand/Barony"
INSTNAME='Barony*_linux64.zip'
## Installation post-processing:
INSTRENAME='Barony*_linux64/Barony'
PRERUN="May need to fill in some missing files:
  ItemImage=$HOME/Programs/Barony/items/images
  cp $ItemImage/Mirror.png $ItemImage/Skeletonkey.png
  cp $ItemImage/Tin.png    $ItemImage/Beartrap.png
"
POSTRUN="Diagnostics are in:
  less -S $HOME/Programs/Barony/log.txt
"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable
