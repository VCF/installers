#!/bin/bash

GAMEDIR="$HOME/Documents/GameFiles"

## Centralize game configuration and save files in a single folder
## ($GAMEDIR, above) for ease of backup. They are tied into their
## expected place with symlinks.

## Copyright (C) 2017 Charles A. Tilford
##   Where I have used (or been inspired by) public code it will be noted

LICENSE_GPL3="

    This program is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/

"

## Support functions
my_dir="$(dirname "$0")"
## Make script path absolute: https://stackoverflow.com/a/4175545
my_dir=`readlink -f "$my_dir"`
. "$my_dir/../systemSetup/_util_functions.sh"



## A few non-game configuration folders are here as well

LOCSHARE="$HOME/.local/share"
# STEAMCOM="$LOCSHARE/Steam/SteamApps/common"
STEAMCOM="$HOME/.steam/steam/steamapps/common"
STEAMLOC="$LOCSHARE/Steam/SteamApps/common"
CONFD="$HOME/.config"
DOCDIR="$HOME/Documents"
PROGRAMS="$HOME/Programs"

## Unclear:
## Super Tux Kart (.local/share is addons only)
## Starmade?

## MAY NEED TO UPDATE:
## RevengeOfTheTitans = Directory name has version number
## TitanAttacks       = Directory name has version number
## Starbound          = Directory name has version name

##    ""            "$LOCSHARE/"
mydirs=(
    "10000000"                    "$CONFD/unity3d/EightyEightGames/10000000"
    "3089"                        "$HOME/3089"
    "AWizardsLizard"              "$CONFD/A Wizard's Lizard"
    "Anomaly"                     "$HOME/.Anomaly"
    "Aquaria"                     "$HOME/.Aquaria"
    "BackToTheFuture"             "$HOME/Telltale Games"
    "Badland"                     "$HOME/.BADLAND"
    "BattleForWesnoth"            "$LOCSHARE/wesnoth"
    "BeatHazard"                  "$LOCSHARE/BeatHazard_Linux2"
    "BitTripRunner2"              "$LOCSHARE/gaijin_games/runner2"
    "BlocksThatMatter"            "$STEAMCOM/Blocks That Matter/Blocks That Matter Save"
    "Capsized"                    "$LOCSHARE/Capsized"
    "CaveStory+"                  "$LOCSHARE/CaveStory+"
    "Cosmochoria"                 "$CONFD/Cosmochoria"
    "CostumeQuest"                "$LOCSHARE/doublefine/costumequest"
    "DontTouchAnything"           "$CONFD/DontTouchAnything"
    "DroidAssault"                "$HOME/.droid_assault_1.92"
    "DroxOperative"               "$HOME/.local/DroxOperative"
    "DustForce"                   "$STEAMCOM/Dustforce/user"
    "DwarfFortress"               "$PROGRAMS/df_linux/data/save"
    "EuroTruckSimulator2"         "$LOCSHARE/Euro Truck Simulator 2"
    "Factorio"                    "$PROGRAMS/Factorio/game/saves"
    "FEZ"                         "$LOCSHARE/FEZ"
    "FarSky"                      "$HOME/.FarSky"
    "FullBore"                    "$HOME/.fullbore"
    "HacknSlash"                  "$LOCSHARE/doublefine/hacknslash"
    "Influent"                    "$CONFD/unity3d/Three Flip Studios/Influent"
    "KerbalSpaceProgram"          "$STEAMCOM/Kerbal Space Program/saves"
    "LoversInADangerousSpacetime" "$LOCSHARE/LoversInADangerousSpacetime"
    "Luftrausers"                 "$HOME/.LUFTRAUSERS"
    "MineCraft"                   "$HOME/.minecraft"
    "MineTest"                    "$HOME/.minetest"
    "OpenBVE"                     "$CONFD/OpenBve"
    "Osmos"                       "$HOME/.Osmos"
    "PixelJunkShooter"            "$LOCSHARE/PJShooter"
    "Proteus"                     "$LOCSHARE/Proteus"
    "RevengeOfTheTitans"          "$HOME/.revenge_of_the_titans_1.80"
    "RiskOfRain"                  "$CONFD/Risk_of_Rain"
    "SaturdayMorningRPG"          "$DOCDIR/SavedGames/SMRPG"
    "SecretsOfRaetikon"           "$HOME/.secrets-of-raetikon"
    "SmallWorld2"                 "$CONFD/Small World 2"
    "Snapshot"                    "$LOCSHARE/Snapshot"
    "SpaceChem"                   "$LOCSHARE/Zachtronics Industries/SpaceChem"
    "SpacePiratesAndZombies"      "$LOCSHARE/spacepiratesandzombies"
    "Starbound"                   "$STEAMCOM/Starbound/storage"
    "StarboundGiraffe"            "$STEAMCOM/Starbound/giraffe_storage"
    "StarboundKoala"              "$STEAMCOM/Starbound/koala_storage"
    "StarMade"                    "$STEAMLOC/StarMade/StarMade/server-database"
    "SteamWorldDig"               "$LOCSHARE/SteamWorldDig"
    "StuntRally"                  "$CONFD/stuntrally"
    "SuperTuxKart"                "$CONFD/supertuxkart"
    "Symphony"                    "$LOCSHARE/Empty Clip Studios"
    "TORCS"                       "$HOME/.torcs"
    "Terraria"                    "$LOCSHARE/Terraria"
    "TheLastTinker"               "$STEAMCOM/The Last Tinker City of Colors/savegames"
    "TheLastTinker"               "$STEAMCOM/The Last Tinker City of Colors/savegames"
    "TheSpatials"                 "$CONFD/TheSpatials"
    "TicketToRide"                "$HOME/.Ticket to Ride"
    "TitanAttacks"                "$HOME/.titan_attacks_2.01"
    "TokiTori2"                   "$LOCSHARE/twotribes/toki_tori_2+"
    "TuxMath"                     "$HOME/.tuxmath"
    "TuxPaint"                    "$HOME/.tuxpaint"
    "Unepic"                      "$LOCSHARE/Unepic"
    "VVVVVV"                      "$LOCSHARE/VVVVVV"
    "WorldOfGoo"                  "$HOME/.WorldOfGoo"
    "Xenonauts"                   "$LOCSHARE/Goldhawk Interactive/Xenonauts"

    
    "Inkscape"                    "$CONFD/inkscape"

    "StarboundServer"             "/home/steam/steamcmd/starbound/storage"
)


if [[ ! -d "$GAMEDIR" ]]; then
    mkdir -p "$GAMEDIR" || die "FAILED to create game directory: $GAMEDIR"
    msg 35 "Created local directory: $GAMEDIR"
fi

msg 46 "

Moving your game files to a central location and linking back to their expected folder...
"
echo
msg 37 "   'Local' directory = The consistent place your files will be stored:"
msg 35 "                       $GAMEDIR"
msg 37 "    'Game' directory = The place the game expects the files to be"
echo ""

i=0
numReq=${#mydirs[@]}
while [ "$i" -lt "$numReq" ]
do
    subDir=${mydirs[$i]}
    fullDir="$GAMEDIR/$subDir"
    ((i++))
    gameDir=${mydirs[$i]}
    gameBkup="${gameDir}-BKUP"
    ((i++))

    if [[ ! -d "$gameDir" ]]; then
        ## The game does not appear installed on this computer
        if [[ -d "$fullDir" ]]; then
            ## But the user has a local data folder for it
            msg '30;47' "###  $subDir ###" 
            msg 33 "    Local game data present, game not installed"
            echo ""
        fi
        continue
    fi

    FD=`setTilda "$fullDir"`
    GD=`setTilda "$gameDir"`

    msg '30;47' "###  $subDir ###"
    ## Set up the local directory
    if [[ -d "$fullDir" ]]; then
        msg 32 "  Local dir in place: $FD"
    else
        mkdir -p "$fullDir" || die "Failed to create $FD"
        if [[ -d "$gameDir" ]]; then
            ## Created the directory anyway so -p will create any parent subdirs
            ## Remove the directory, and move the existing one into local dir
            rmdir "$fullDir" || \
                die "Failed to remove empty local directory:\n    $FD"
            mv "$gameDir" "$fullDir" || \
                die "Failed to copy game directory to newly-created local dir:\n    $GD\n    $FD"
            msg 35 "  Game directory moved to local directory\n    $FD"
        else
            msg 35 "  Created empty local directory: $FD"
        fi
    fi

    
    ## Link game location to local dir, making backup if needed
    if [[ -h "$gameDir" ]]; then
        ## The game directory is already a link. Normalize it:
        chk=`readlink -f "$gameDir"`
        ## Normalize the target, too (eg remove trailing slash):
        chk2=`readlink -f "$fullDir"`
        [[ "$chk" == "$chk2" ]] || \
            die "A link already exists in the game directory, but it points somewhere unexpected:\n    Game link: $GD\n    Expected: $FD\n    Actual: $chk\n  Please resolve this issue!"
        msg 32 "         Linked from: $GD"
        echo  ""
        continue
    elif [[ -d "$gameDir" ]]; then
        [[ -d "$gameBkup" ]] && \
            die "Both the game directory and a backup already exist.\n  Please resolve this by moving/deleting one of these:\n    $gameDir\n    $gameBkup"
        mv "$gameDir" "$gameBkup" || \
            die "Failed to move game directory to backup location:\n  $GD\n  $gameBkup"
        msg '0;34;43' "  Game directory existed - moved to backup\n    $gameBkup"
    fi
    ln -s "$fullDir" "$gameDir" || \
        die "Failed to make link:\n  Local: $FD\n   Game: $GD"
    msg 35 "  Game files linked!\n    Local: $FD\n     Game: $GD"
    echo ""
done

msg 34 "Complete! Please make sure that your local directory contains the files you expect to be there
"

