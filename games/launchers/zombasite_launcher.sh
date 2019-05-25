#!/bin/bash

## Location of the executable:
PROGDIR="Zombasite"
LAUNCH="start.sh"
## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='zombasite_*.sh'
## Installation post-processing:
INSTICON="$PROGDIR.png"
# INSTSAVEDIR="$HOME/Programs/$PROGDIR/game/files/saves"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

function CHECKLIBPNG {
    ## Needs v12 of libpng for some reason
    ## Check for library: https://serverfault.com/a/513938
    hasv12=$(ldconfig -p | grep 'libpng12.so.0' | grep i386)
    if [[ -z "$hasv12" ]]; then
        msg "$BgYellow;$FgRed" "
You need to install libpng12.so.0

  This will require sudo, so I won't do it automatically. Instead, you
  should run the following commands, after verifying that they're not
  going anyplace sketchy:
"
        ## Based in part on https://stackoverflow.com/a/55055602
        ##   but with a different URL (the kernel.org link was unreachable)
        msg "$FgBlue" "
  ## Get the 32-bit deb file from ubuntu.com
  wget -v -O /tmp/libpng12.deb \\
     http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_i386.deb

  ## Install it - need to be root via sudo!
  sudo dpkg -i /tmp/libpng12.deb

  # Remove the temp file, if you succeed
  rm /tmp/libpng12.deb

"
        exit
    fi
}

CHECKLIBPNG

find_and_run_executable "$@"
