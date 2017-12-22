#!/bin/bash

## Location of the executable:
PROGDIR="Crea"
LAUNCH="Crea"
## Location of the installer:
INSTDIR="Humble Indie Bundle/$PROGDIR"
INSTNAME='crea_v*_linux.tar.gz'
## Installation post-processing:
INSTICON="crea_logo.png"
function INSTFUNCTION {
    ## Save data are in multiple locations, link them into one place:
    cd "$GAMEDIR/$PROGDIR"
    sd="SaveData"
    [[ -d "$sd" ]] && return
    mkdir "$sd"
    subdirs=(characters worlds)
    for subdir in ${subdirs[@]}; do
        if [[ -d "$subdir" ]]; then
            mv "$subdir" "$sd"
        else
            mkdir "$sd/$subdir"
        fi
        ln -s "$sd/$subdir" "$subdir"
    done
}
## .. and then move it to standard location:
INSTSAVEDIR="$HOME/Programs/$PROGDIR/SaveData"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"
