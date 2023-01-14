#!/bin/bash

## Utility function for  colored terminal text
function ansiStart {
    echo -e "\033[1;${1}m"
}
function ansiEnd {
    echo -e "\033[0m"
}
## https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
FgRed="31"
FgGreen="32"
FgBlue="34"
FgYellow="33"
BgYellow="43"
BgWhite="47"
function msg {
    ## Colorized terminal message.
    COL=$1 # The ANSI color code(s)
    MSG=$2 # The text to print
    [[ -z "$COL" ]] && col="32"
    >&2 echo -e "$(ansiStart "$COL")${MSG}$(ansiEnd)";
}

## Linux location of save files:
baseDir="$HOME/.local/share/7DaysToDie/Saves"
## The game folder in question:
gameName="$1"
## What to do if a backup already exists:
handleBackup="$2"

if [[ -z "$gameName" ]]; then
    msg "$FgRed" "
Please provide the name of the game to install. Your saves should be in:"
    msg "$FgBlue" "  $baseDir"
    msg "$FgRed" "... and the current contents are:
"
    found="$(ls -lh "$baseDir/" | grep '^d')"
    msg "$FgGreen" "$found
"
    exit
fi

gameDir="$baseDir/$gameName"

if [[ ! -d "$gameDir" ]]; then
    msg "$FgRed" "
Could not find a game named:"
    msg "$FgYellow" "  $gameName"
    msg "$FgRed" "Available games are:
"
    found="$(ls -lh "$baseDir/" | grep '^d')"
    msg "$FgGreen" "$found
"
    echo ""
    exit
fi

## Backup the save folder:
backupDir="$HOME/7DaysToDie_${gameName}_Backup"

if [[ -d "$backupDir" ]]; then
    if [[ -z "$handleBackup" ]]; then
        msg "$FgYellow" "
Warning! Backup directory already exists:"
        msg "$FgBlue" "  $backupDir"
        msg "$FgYellow" "
Your options are to:
  * 'keep' - This will keep the backup folder unchanged. Be aware that the
    folder may be out of date compared to your current game state
  * 'replace' - This will delete the backup folder and replace it with the
    current state. Be aware that you may wish to preserve the old state?
  * Exit this script and remove or move the folder yourself. You can exit
    with ctrl-c or any response other than 'keep' or 'replace'

Do not include the quotes in your response. You can also include your choice as
the second argument when you run the script (after the game name).
"
        ## Get user response from command line
        read -p "$(ansiStart $BgYellow) $(ansiStart $FgRed)What do you wish to do?$(ansiStart $FgBlue) $(ansiStart $BgWhite)[keep/replace/quit]$(ansiEnd) " handleBackup
    fi
    
    if [[ "$handleBackup" == "keep" ]]; then
        msg "$FgGreen" "
Keeping existing backup folder:"
        msg "$FgBlue" "  $backupDir"
        echo ""
    elif [[ "$handleBackup" == "replace" ]]; then
        msg "$FgGreen" "
Removing existing backup folder, replacing with current folder state
"
        
    else
        msg "$FgYellow" "
RESTORE ABORTED. No changes performed.
"
        exit
    fi
fi

if [[ ! -d "$backupDir" ]]; then
    msg "$FgGreen" "
Backing up the save folder from:"
    msg "$FgBlue" "  '$gameDir'"
    msg "$FgGreen" "to:"
    msg "$FgBlue" "  '$backupDir'"
    echo ""
    rsync -av "$gameDir" "$backupDir"
    msg "$FgGreen" "
Backup complete:"
    bkls="$(du -hs "$backupDir")"
    msg "$FgBlue" "  $bkls"
fi


## Find backup files:
bakFiles="$(find "$gameDir" -iname '*.bak*')"

## Split string on newlines: https://stackoverflow.com/a/19772067
IFS=$'\n' read -rd '' -a SPLITLINES <<< "$bakFiles"
msg "$FgGreen" "Replacing impacted files with their backups:
"
for path in "${SPLITLINES[@]}"
do
    msg "$FgBlue" "  $path"
done


