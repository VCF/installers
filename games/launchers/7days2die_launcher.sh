#!/bin/bash

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

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

## Split string on newlines: https://stackoverflow.com/a/19772067
IFS=$'\n' read -rd '' -a worldDirs <<< "$(ls -1 "$srcDir")"
for wd in "${worldDirs[@]}"
do
    sw="$srcDir/$wd" # World directory in saves
    [[ ! -d "$sw" ]] && continue # Wasn't a directory
    ## Now find the game directories in this world
    IFS=$'\n' read -rd '' -a gameDirs <<< "$(ls -1 "$sw")"
    for gd in "${gameDirs[@]}"
    do
        [[ $vb != "" ]] && echo "  Game \"$gd\""
        swg="$sw/$gd"           # Game directory in saves
        ## Archive this world-game, if needed
        subfolder="7days/$wd"
        archiveFolder "$swg" "$subfolder"
        ## Keep only the three most recent backups for each world
        trimBackups "$swg" "$subfolder" 3
    done
done
