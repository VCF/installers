#!/bin/bash

PROGDIR="7 Days to Die"
STEAMID="251570"

PRERUN="
7 Days to Die can irreversibly corrupt your save data if the application
crashes (about once every 30-50 hours in the author's experience) or if you
lose power. Your save games will be backed up BEFORE each launch to allow
recovery from such events, at least to the state before you started the
game. For every World/Game combination, at most $keepFiles saves will be kept,
stored as gzipped tarballs.
"

POSTRUN="
Your game was backed up just before you started. When you run the launcher
again, it will make a new backup of the current game state. If you would
like to make another backup now, run the launcher with an additional
argument 'help'.

The game is NOT backed up by default AFTER running because there's a non-trivial
chance that the save has been corrupted. :-(
"

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

## pgrep was new to me ...
##   https://stackoverflow.com/a/6225730
STEAMUP="$(pgrep steam)"

if [[ "$STEAMUP" == "" ]]; then
    ## If steam was not already running, it will launch and be tied to this
    ## shell, which can be annoying. So start steam in the background
    msg "$FgCyan" "Starting Steam in the background ..."

    ## Truly push to background with disown and (or?) nohup
    ##   https://stackoverflow.com/a/29681504
    ##   https://unix.stackexchange.com/a/269899
    nohup steam &>/dev/null & disown;
fi

## Defines the resolution of the tar.gz filename:
backupGranularity "second"
## How many backups do we keep at any given time?
keepFiles=5

## Split string on newlines: https://stackoverflow.com/a/19772067
msg "$FgCyan" "Backing up worlds before game run ..."
lnkTxt="Link to actual Steam folder"
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
        trimBackups "$swg" "$subfolder" $keepFiles # Keep at most keepFiles
        ## Make a symlink back to save folder
        sfpath=$(backupSubfolder "$swg" "$subfolder")
        lpath="$sfpath/$lnkTxt"
        if [[ ! -L "$lpath" ]]; then
            ln -s "$sw" "$lpath"
        fi
    done
done
echo ""

desktopIcon
find_and_run_executable "$@"

