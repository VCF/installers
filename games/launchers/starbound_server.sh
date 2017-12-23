#!/bin/bash

## Location of the executable:
PROGDIR="StarboundServer"
PROGSUBDIR="linux"
LAUNCH="starbound_server"
NOREDIRECT=true
## Location of the installer:
INSTDIR="Humble Indie Bundle/Starbound"
INSTNAME='starbound_*_linux.zip'
## Installation post-processing:
INSTRENAME='starbound_*_linux/'$PROGDIR
INSTSAVEDIR="$HOME/Programs/Starbound/storage"
INSTICON="StarboundServer.png"
function INSTFUNCTION {
    ## Custom post-installation function - set executable for several scripts
    chmod u+x "$GAMEDIR/$PROGDIR/linux/starbound"
    chmod u+x "$GAMEDIR/$PROGDIR/linux/starbound_server"
    chmod u+x "$GAMEDIR/$PROGDIR/linux/run-client.sh"
    
    ## PROGDIR manages individual applications, so make a symlink
    ln -s "$PROGDIR " "$GAMEDIR/Starbound"
}


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
