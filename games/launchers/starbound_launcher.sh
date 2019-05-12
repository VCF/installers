#!/bin/bash

## Location of the executable:
PROGDIR="Starbound"
PROGSUBDIR="linux"
LAUNCH="starbound"
## Location of the installer:
INSTDIR="Humble Indie Bundle/Starbound"
INSTNAME='starbound_*_linux.zip'
## Installation post-processing:
##INSTRENAME='starbound_*_linux/'$PROGDIR
UNPACKDIR="$PROGDIR" # Zip archive does not have a containing folder
INSTSAVEDIR="$HOME/Programs/Starbound/storage"
INSTICON="Starbound2.png"

function INSTFUNCTION {
    ## Custom post-installation function - set executable for several scripts
    chmod u+x "$GAMEDIR/$PROGDIR/linux/starbound"
    chmod u+x "$GAMEDIR/$PROGDIR/linux/starbound_server"
    chmod u+x "$GAMEDIR/$PROGDIR/linux/run-client.sh"
    chmod u+x "$GAMEDIR/$PROGDIR/linux/run-server.sh"
    ## PROGDIR manages individual applications, so make a symlink
    ln -s "$PROGDIR" "$GAMEDIR/StarboundServer"
}

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./"
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
