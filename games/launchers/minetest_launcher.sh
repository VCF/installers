#!/bin/bash

## Location of the executable:
PROGDIR="Minetest"
LAUNCH="bin/minetest"

## Location of the installer:
INSTGIT="https://github.com/minetest/minetest.git"
## Required modules
APTPACKAGES="
build-essential
libirrlicht-dev
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
INSTRENAME='minetest/Minetest'
INSTICON="$PROGDIR.png"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

INSTSAVEDIR="$GAMEDIR/$PROGDIR/worlds"

function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    ## Basic game
    install_git_custom "minetest" "minetest_game" "" \
                       "games/minetest_game" "--depth 1"
    ## Reasonably good modules
    
    install_zip_custom "https://codeload.github.com/minetest-LOTR/Lord-of-the-Test/zip/v1.1.0" "games" "Lord-of-the-Test-1.1.0"
    install_git_custom "D00Med" "LegendofMinetest" "" "games/LegendofMinetest"
    install_git_custom "D00Med" "farlands"         "" "games/farlands"
    install_git_custom "maikerumine" "aftermath"   "" "games/aftermath"
    install_git_custom "Amaz1" "moontest"          "" "games/moontest"
    install_git_custom "cdqwertz" "rpgtest"        "" "games/rpgtest"
    install_git_custom "azekillDIABLO" "VoxBox"    "" "games/VoxBox"
    install_git_custom "LNJ2" "Wasteland"          "" "games/Wasteland"
    install_git_custom "azekillDIABLO" "Voxellar"  "" "games/Voxellar"
    install_git_custom "minetest-technic" "technic_game" \
                       "" "games/technic_game" "--recursive"
    
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
