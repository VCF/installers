#!/bin/bash

whatIsThis="

This code runs on Linux, and presumes a Steam installation

7 Days to Die is a remarkable game with an enraging fault - it will randomly
crash and corrupt the save file. There is an awkward mechanism to recover the
game, and while this seems to preserve terrain changes, it <sometimes> reverts
the player back to Level 1, and always reverts the world back to Day 1.

This script is designed to make frequent backups of the core file to
preserve btoth player level as well as game day.


"

## Be more chatty if this is being run by a human (ie not cron)
vb=""
if [ -t 1 ] ; then 
    vb="verbose"
fi


# We only execute when 7 Days is running
#   Check if executable is present - https://stackoverflow.com/a/9271229
gamePid=$(pgrep '7DaysToDie')

if [[ -z "$gamePid" ]]; then
    # Nope, looks like no active processes.
    if [[ $vb == "" ]]; then
        exit # Just quit for non-interactive sessions
    else
        echo "[INFO] 7 Days is not currently running"
    fi
fi

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

# Assure the target folder is present
mkdir -p "$targDir"


## We are expecting this script to run every X minutes (suggested 5)
## We will have a unique 'minute flag' to segregate backups.
minFlag=$(date +'%M')

## The file that gets corrupted, and we want to preserve
basettw="main.ttw"

## Game files are held at two levels - "World" and "Game". We will
## preserve that structure in the backups
[[ $vb != "" ]] && echo "
Backing up: $srcDir
"

## Split string on newlines: https://stackoverflow.com/a/19772067
IFS=$'\n' read -rd '' -a worldDirs <<< "$(ls -1 "$srcDir")"
for wd in "${worldDirs[@]}"
do
    sw="$srcDir/$wd" # World directory in saves
    mkdir -p "$sw" 
    ## Now find the game directories in this world
    IFS=$'\n' read -rd '' -a gameDirs <<< "$(ls -1 "$sw")"
    for gd in "${gameDirs[@]}"
    do
        [[ $vb != "" ]] && echo "World \"$wd\" Game \"$gd\""
        swg="$sw/$gd"           # Game directory in saves
        ttw="$swg/$basettw"     # The key file we're looking for
        if [[ ! -f "$ttw" ]]; then
            echo "TTW file not found? $ttw"
            continue
        fi
        
        ## We found a file, set up to copy it        
        twg="$targDir/$wd/$gd"  # Game directory in backup
        mkdir -p "$twg"         # Assure it exists

        ## What is the most recent backup file already there?
        latest="$(ls -1t "$twg/*.ttw")"

        fn="$twg/${minFlag}-$basettw" # The backup file we're planning to make
        fmd5="${fn}.md5"              # MD5 checksum file of the above file
        fntmp="${fn}.tmp"             # .tmp backup file
        f5tmp="${fmd5}.tmp"           # .tmp MD5 file
        
        ## Copy the game file to the backup folder (using the .tmp name)
        ## We <could> calculate MD5 from the file in the game folder,
        ## but it could change while we're doing that. A copy of the file
        ## should be consistent
        cp "$ttw" "$fntmp"
        
        ## Calculate MD5 checksum
        ##   Assignment to strip file path https://stackoverflow.com/a/5773761
        md5=($(md5sum "$fntmp"))
        echo "$md5" > "$f5tmp" # Write to temp MD5 file
        
        if [[ -f "$latest" ]]; then
            ## OK, we found the most recent file. Is it different than
            ## the file we just copied?
            if [[ cmp --silent "${latest}.md5" "$f5tmp" ]]; then
                ## The checksums appear to be identical. We do not need
                ## to do anything, other than clear the temp files
                rm "$fntmp" "$f5tmp"
                continue
            fi
        fi

        ## This file has changed. Keep it after removing the .tmp suffix
        mv "$fntmp" "$fn"
        mv "$f5tmp" "$fmd5"
        [[ $vb != "" ]] && echo "    [BACKUP] \"$(ls -sh "$fn")\""
    done
done
