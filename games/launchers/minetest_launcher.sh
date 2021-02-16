#!/bin/bash

## Location of the executable:
PROGDIR="Minetest"
LAUNCH="bin/minetest"

## Location of the installer:
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='minetest-5.3.0.tar.gz'

## Required modules
APTPACKAGES="
build-essential
libirrlicht-dev
libirrlicht1.8
cmake
libbz2-dev
libpng-dev
libjpeg-dev
libxxf86vm-dev
libgl1-mesa-dev
libsqlite3-dev
libogg-dev
libvorbis-dev
libopenal-dev
libcurl4-gnutls-dev
libfreetype6-dev
zlib1g-dev
libgmp-dev
libjsoncpp-dev
"
## Installation post-processing:
INSTRENAME='minetest-*/Minetest'
INSTICON="$PROGDIR.png"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

INSTSAVEDIR="$GAMEDIR/$PROGDIR/worlds"

function topZipFolder {
    ## Find the containing folder for a zip archive
    zpath="$1"
    topdir=$(unzip -l "$zpath" | egrep '^ *[0-9][0-9]* *.*\/ *' | head -n1 | sed 's/\/.*$//' | sed 's/^.*   *//')
    echo "$topdir"
}

function unpackCategory {
    subd="$1"
    msg "$FgRed" "
------------------ Unpacking $subd ------------------
"
    cd "$subd"
    linesToArray "$(ls -1 "$instFolder/$subd/"*.zip)"
    for path in "${SPLITLINES[@]}"
    do
        topd="$(topZipFolder "$path")"
        # echo ">>$topd<<"
        install_zip_custom "$path" "" "$topd"
    done
    cd ..
}

function INSTFUNCTION {
    findInstaller
    instFolder="$(dirname "$installer")"
    cd "$GAMEDIR/$PROGDIR"

    #### ---- Textures ---- ####
    unpackCategory "textures"

    #### ---- Games ---- ####
    unpackCategory "games"
    
    #### ---- Mods ---- ####
    unpackCategory "mods"
    
    ## Compile
    if [[ -s "$LAUNCH" ]]; then
        msg "$FgCyan" "Main game engine has already been compiled"
    else
        msg "$FgMagenta;$BgYellow" "  ---- COMPILING MINETEST ----  "
        cmake . -DRUN_IN_PLACE=TRUE && make
        if [[ -s "$LAUNCH" ]]; then
            msg "$FgGreen" "  Apparently succesful compilation"
        else
            msg "$FgRed;$BgYellow" "  Could not find launcher: $LAUNCH  "
        fi
        ## You can build a bare server by specifying -DBUILD_SERVER=TRUE
    fi
}

find_and_run_executable "$@"
