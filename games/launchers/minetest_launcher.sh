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

    GhUrl="https://codeload.github.com"
    GlUrl="https://gitlab.com"
    mtcUrl="https://content.minetest.net/uploads"
    NabUrl="https://notabug.org"
    mTm="minetest-mods"

    ## Reasonably good games
    install_zip_custom "$GhUrl/minetest-LOTR/Lord-of-the-Test/zip/v1.2.1" \
                       "games" "Lord-of-the-Test-1.2.1"
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
    
    
    ## Nice mods
    install_git_custom "$mTm" "anvil"             "" "mods/anvil"
    install_git_custom "$mTm" "craftguide"        "" "mods/craftguide"
    install_git_custom "$mTm" "crops"             "" "mods/crops"
    install_git_custom "$mTm" "digilines"         "" "mods/digilines"
    install_git_custom "$mTm" "digtron"           "" "mods/digtron"
    install_git_custom "$mTm" "item_drop"         "" "mods/item_drop"
    install_git_custom "$mTm" "mesecons"          "" "mods/mesecons"
    install_git_custom "$mTm" "moreblocks"        "" "mods/moreblocks"
    install_git_custom "$mTm" "moreores"          "" "mods/moreores"
    install_git_custom "$mTm" "mydoors"           "" "mods/mydoors"
    install_git_custom "$mTm" "stamina"           "" "mods/stamina"
    install_git_custom "$mTm" "technic"           "" "mods/technic"
    install_git_custom "$mTm" "unified_inventory" "" "mods/unified_inventory"
    install_git_custom "$mTm" "wielded_light"     "" "mods/wielded_light"
    install_git_custom "$mTm" "stargate"          "" "mods/stargate"
    install_git_custom "AiTechEye" "bows"         "" "mods/bows"
    # install_git_custom "$mTm" ""       "" "mods/"
 
    install_git_custom "HeroOfTheWinds" "minetest-caverealms" \
                       "" "mods/caverealms"
    install_git_custom "jordan4ibanez" "Hoppers" "" "mods/hoppers"
    ## install_git_custom "VanessaE" "pipeworks" "$GlUrl" "mods/pipeworks"
    
    install_zip_custom "$mtcUrl/CmnzkAG1Y1.zip" "mods/pipeworks" "models"
    
    install_zip_custom "$GhUrl/stujones11/minetest-3d_armor/zip/version-0.4.13"\
                       "mods" "minetest-3d_armor-version-0.4.13"
    install_zip_custom "$GhUrl/rubenwardy/awards/zip/v3.3.0" \
                       "mods" "awards-3.3.0"

    install_zip_custom "$GlUrl/VanessaE/basic_materials/-/archive/master/basic_materials-master.zip" "mods" "basic_materials-master"
    
    ########## Mobs ##########
    install_zip_custom "$NabUrl/TenPlus1/mobs_redo/archive/20181016.zip" \
                       "mods" "mobs_redo"
    install_zip_custom "$NabUrl/TenPlus1/ethereal/archive/2020-04-06.zip" \
                       "mods" "ethereal"
    install_git_custom "minetest-mobs-mods" "dmobs"  "" "mods/dmobs"
    ## install_git_custom "h4ml3t" "mobs_sidhe"         "" "mods/mobs_sidhe"
    install_git_custom "h4ml3t" "mobs_others"        "" "mods/mobs_others"
    install_git_custom "ElCeejoYT" "paleotest"       "" "mods/paleotest"
    install_git_custom "NathanSalapat" "arctic_life" "" "mods/arctic_life"
    install_git_custom "Christian9akaCeej" "prehistoric_life" \
                       "" "mods/prehistoric_life"
    install_zip_custom "$NabUrl/TenPlus1/mobs_monster/archive/20181016.zip" \
                       "mods" "mobs_monster"
    install_git_custom "Rochambeau" "smobs_monster" "$GlUrl" "mods/smobs_monster"
    install_git_custom "Rochambeau" "settlements"   "$GlUrl" "mods/settlements"
    install_git_custom "Rochambeau" "smobs_animals" "$GlUrl" "mods/smobs_animals"
    ## https://wiki.minetest.net/Mods/Not_So_Simple_Mobs
    ## install_zip_custom "$GhUrl/NPXcoot/nssm/zip/v3.0" "mods" "nssm-3.0"

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
