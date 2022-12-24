#!/bin/bash

PROGDIR="7 Days to Die"
STEAMID="251570"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

# The first argument is where the backup files should be saved
#   It defaults to '7daystodie_backups' in your home folder
targDir="${1:-$HOME/7daystodie_backups}"

# The second argument is where the game normally saves files
#   It defaults to the standard location (as of Dec 2022)
srcDir="${2:-$HOME/.local/share/7DaysToDie/Saves}"

if [[ ! -d "$srcDir" ]]; then
    ## The source directory does not exist?
    echo "[ERROR] Failed to find game saves: $srcDir"
    exit
fi


backupGranularity "second"

PRERUN="
7 Days to Die can irreversibly corrupt your save data if the application
crashes (about once every 100 hours in the author's experience) or if you
lose power. Your save games will be backed up before each launch to allow
recovery from such events, at least to the state before you started the
game. For every World/Game combination, at most 3 saves will be kept, stored
as gzipped tarballs.
"

## Split string on newlines: https://stackoverflow.com/a/19772067
msg "$FgCyan" "Backing up worlds before game run ..."
lnkTxt="Link to this worlds save game folder"
IFS=$'\n' read -rd '' -a worldDirs <<< "$(ls -1 "$srcDir")"
for wd in "${worldDirs[@]}"
do
    sw="$srcDir/$wd" # World directory in saves
    [[ ! -d "$sw" ]] && continue # Wasn't a directory
    ## Now find the game directories in this world
    IFS=$'\n' read -rd '' -a gameDirs <<< "$(ls -1 "$sw")"
    for gd in "${gameDirs[@]}"
    do
        msg "$FgCyan" "  $wd -- $gd"
        swg="$sw/$gd"           # Game directory in saves
        subfolder="7days/$gd__$wd"
        archiveFolder "$swg" "$subfolder" # Archive this world-game, if needed
        trimBackups "$swg" "$subfolder" 3 # Keep only 3 most recent backups
        ## Make a symlink back to save folder
        sfpath=$(backupSubfolder "$swg" "$subfolder")
        lpath="$sfpath/$lnkTxt"
        if [[ ! -L "$lpath" ]]; then
            ln -s "$swg" "$lpath"
        fi
    done
done
echo ""

POSTRUN="
Your game was backed up just before you started. When you run the launcher
again, it will make a new backup of the current game state. If you would
like to make another backup now, run the launcher with an additional
argument 'help'.

The game is NOT backed up by default after running because there's a non-trivial
chance that the save has been corrupted. :-(
"


desktopIcon
find_and_run_executable "$@"

