#!/bin/bash

LAUNCHERNOTE="

Minetest is no longer easily installed via source
Use PPA instead

"

## Not really a directory, but a name used by some folders:
PROGDIR="Minetest"
## Executable name after installation from repository:
LAUNCH="minetest"


## The name of the application as registered in your system's apt repository
INSTREPO="minetest"
## If not a standard application, link to the PPA instructions
INSTPPA="https://launchpad.net/~minetestdevs/+archive/ubuntu/stable"

## Filename of launcher icon (looks in default folders):
INSTICON="Minetest.png"


my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

INSTSAVEDIR="$HOME/.minetest/worlds"

## Notes shown before program is executed
PRERUN="
Minetest supports multiple 'games', none of which come already installed
You can easily select games inside the application, but it is difficult to
judge what they are. You can browse options better on the website:

  https://content.minetest.net/packages/?type=game

Popular games based on stars / downloads with last update, as of Feb 2024:

   15 337563 2023-12 MineClone2 
   30 103803 2024-02 NodeCore
   21 100038 2024-01 Minetest Game
    4  37840 2022-07 Lord of the Test
   12  33499 2023-12 MeseCraft
   17  28492 2024-01 Exile
   
Minetest also supports multiple mods, also installed inside the game, as
well as sometimes being installed automatically as dependencies for a game
or another mod. They are also more easily browsed on the website. 

  https://content.minetest.net/packages/?type=mod

Some popular mods: stars, downloads, updated.

   22 172368 2024-01 Mesecons
   21 130219 2023-04 i3 (inventory management)
    7 127886 2024-01 Technic
   11 127124 2023-12 Mobs Animal
    5 119702 2023-10 Homedecor
   10 116144 2024-01 Nether
   18 115231 2024-01 Unified Inventory
    9 114527 2024-01 Farming Redo
   12 109560 2024-01 Mobs Monster
    3 109074 2023-12 Basic Materials and items
   36 102629 2024-01 Animalia
   31  97466 2022-10 Draconis
    9  90065 2023-07 Advanced Trains
   12  88720 2023-12 Petz
    2  84255 2018-05 Vehicles
   18  72346 2023-11 WorldEdit
   10  71892 2024-02 Pipeworks
    2  71783 2023-03 Biofuel
    7  70333 2024-01 More Ores
   10  69958 2022-08 More Blocks
   18  65765 2024-01 Ethereal NG
    8  55444 2023-12 Plantlife
    3  53405 2023-08 Mobs NPC
    9  52770 2023-06 Villages
    8  48862 2024-01 More Trees!
    8  44665 2023-10 Ranged Weapons
   16  42485 2024-02 Automobiles Pack
    4  38181 2023-10 Mob Horse
   18  33324 2023-11 Techage Modpack
    4  26579 2020-10 Weather
    3  24679 2020-03 Wildlife
    6  23267 2024-01 X Bows
    9  21558 2023-01 Storage Drawers
    5  21119 2023-11 Anvil
   11  19907 2024-02 Wilhelmines Animal World
    8  19901 2024-01 Digtron
    8  19672 2023-12 Dwarf Fortress style caverns
    2  18303 2022-12 Morelights

If a mod insists that it needs 'default', the mod can still be installed but
will only work on the semi-default 'Minetest Game' game.

-----
Consistent Technic build?

Minetest Game
+ Technic
  + More Blocks
  + More Ores
  + Unified Inventory
+ Unified Inventory
+ i3
  + awards
  + 3D Armor
  + SkinsDB
+ Nether
+ Animalia
+ Mobs Animal


"

find_and_run_executable "$@"

srcDir="$SAVEDIR/$PROGDIR"
if [[ -d "$srcDir" ]]; then
    saveLocation
    backupSubfolder
    keepFiles=10  # Number of backups to keep
    msg "$FgCyan" "Backing up worlds to \"$BACKUPDIR/$PROGDIR\""

    IFS=$'\n' read -rd '' -a worldDirs <<< "$(ls -1 "$srcDir")"
    for wd in "${worldDirs[@]}"
    do
        sw="$srcDir/$wd" # World directory in saves
        [[ ! -d "$sw" ]] && continue # Wasn't a directory
        # msg "$FgCyan" "  World: $sw"
        archiveFolder "$sw" "$PROGDIR" # Archive this world-game, if needed
        trimBackups "$sw" "$PROGDIR" $keepFiles # Keep at most keepFiles
    done
    echo ""
fi
