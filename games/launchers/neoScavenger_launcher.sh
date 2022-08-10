#!/bin/bash

## Location of the executable:
PROGDIR="NEO Scavenger"
LAUNCH="start.sh"

## Location of the installer on your file system:
INSTDIR="GOG/Neo Scavenger"
INSTNAME='gog_neo_scavenger_*.sh'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"


## Notes shown before program is executed
PRERUN="
  Won't run on 64-bit systems without installing some 32 bit libraries
  Unfortunately one of these is libcurl3, and adding the i386 version
  would result in losing 64-bit versions of:
    cmake curl libcurl4 r-base-core
  ... and I want to keep all of those, including R.
"
msg "$FgRed" "

$PRERUN

"

exit


## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
## 32-bit libraries needed for JRE
##   https://stackoverflow.com/a/17355914
## libssl3 lives in libnss3 - also need 32 bit version
##   https://packages.ubuntu.com/bionic/amd64/libnss3/filelist
## null pointer = libcurl
##   https://www.pcgamingwiki.com/wiki/NEO_Scavenger
##     ... but installing libcurl3:i386 would force removal of:
##         cmake curl libcurl4 r-base-core
##         ... so hard pass on that ...
APTPACKAGES='libxt6:i386 libnss3:i386 libatk-adaptor:i386 gtk2-engines:i386 gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386'

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run after installation:
#function INSTFUNCTION {
#  echo "For example, properly setting executable bits"
#  addDLC 'foobar_pro_DLC_pack_*.sh'
#}
## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}


find_and_run_executable "$@"
