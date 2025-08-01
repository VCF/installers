
#!/bin/bash

## Functions to use for backup and synchronization

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

## script folder: https://stackoverflow.com/a/246128
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$my_dir/_util_functions.sh" # Source in utility functions

if [[ -z "$BACKUPDIR" ]]; then
    BACKUPDIR="$HOME/FileBackups"
    msg "$FgMagenta" "
BACKUPDIR was not defined, using: $BACKUPDIR
  (you may want to set that variable to something else)
"
fi

function lastModified {
    ## One argument, the file or folder to check. Will return the most
    ## recent modified time, in epoch seconds
    Item=$(readlink -f "$1")
    if [[ -d "$Item" ]]; then
        ## Newest mod time in a folder @Paulo Scardine :
        ##   https://stackoverflow.com/a/4997339
        ## Using %Y for 'last data modification, seconds since Epoch'
        rv=$(find "$Item" -exec stat \{} --printf="%Y\n" \; | sort -n -r | head -n 1)
    else
        ## Single file
        rv=$(stat "$Item" --printf="%Y\n")
    fi
    echo "$rv"
}

function backupSubfolder {
    SRC=$(readlink -f "$1") # Source folder, de-linked
    SubDir="$2" # Optional intermediate subdirectory
    DirName=$(basename "$SRC")
    rv="$BACKUPDIR"
    if [[ ! -z "$SubDir" ]]; then
        if [[ "$SubDir" =~ ^/ ]]; then
            ## DO NOT QUOTE ^ : https://stackoverflow.com/a/2172367
            ## Absolute path, use as-is
            rv="$SubDir"
        else
            ## Presume this is a subdirectory
            rv="$rv/$SubDir" # subdirectory
        fi
    fi
    rv="$rv/$DirName"
    echo "$rv"
}

datePattern="%Y-%m-%d"
findPattern="????-??-??"
nicePattern="Day"
function backupGranularity {
    ## Set the time interval to distinguish backups
    ## Lower case: https://stackoverflow.com/a/2264537
    req=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    if [[ -z $req || "$req" == "" ]]; then
        ## No value passed
        :
    elif [[ "$req" == "second" || $req == "sec" ]]; then
        datePattern="%Y-%m-%d_%H%M%S"
        findPattern="????-??-??_??????"
        nicePattern="Second"
    elif [[ "$req" == "minute" || $req == "min" ]]; then
        datePattern="%Y-%m-%d_%H%M"
        findPattern="????-??-??_????"
        nicePattern="Minute"
    elif [[ "$req" == "hour" || $req == "hr" ]]; then
        datePattern="%Y-%m-%d_%H"
        findPattern="????-??-??_??"
        nicePattern="Hour"
    elif [[ "$req" == "day" ]]; then
        datePattern="%Y-%m-%d"
        findPattern="????-??-??"
        nicePattern="Day"
    elif [[ "$req" == "dayofweek" || "$req" == "weekday" || $req == "dow" ]]; then
        datePattern="%Y-%m-%d_%a"
        findPattern="????-??-??_???"
        nicePattern="Day of Week"
    elif [[ "$req" == "month" ]]; then
        datePattern="%Y-%m"
        findPattern="????-??"
        nicePattern="Month"
    else
        msg "$FgYellow" "Unrecognized time granularity request: \"$req\"
  Recognized values: second, minute, hour, day, weekday, month
  Time granularity kept at: $nicePattern ($datePattern)"
    fi
}

function allBackups {
    ## Find all backups currently held
    sf=$(backupSubfolder "$1" "$2")
    ab=$(ls -1t "$sf"/${findPattern}.tar.gz 2> /dev/null)
    ## Text block to array: https://stackoverflow.com/a/5257398
    IFS=$'\n'
    AllBackups=($ab)
    unset IFS
    # echo "$ab"
}

function trimBackups {
    ## Remove all but the `n` most recent backups from a folder
    allBackups "$1" "$2"
    req="$3"
    if [[ "$req" =~ ^[0-9]{1,}$ ]]; then
        for f in "${AllBackups[@]:$req}"
        do
            rm "$f"
            if [[ -f "$f" ]]; then
                msg "$FgRed;$BgYellow" "ERROR - failed to remove old file:
  $f"
            else
                msg "$FgWhite" "  Old save deleted: $f"
            fi
        done
    else
        msg "$FgYellow" "Trim request '$req' was not understood"
    fi
}

function mostRecentBackup {
    ## What is the most recent backup file for a folder?
    allBackups "$1" "$2"
    echo "${AllBackups[0]}"
}

function archiveFolder {
    ## $1 - The folder or file to archive
    ## $2 - Optional subfolder to put the archive under
    SRC=$(readlink -f "$1")             # Source folder, de-linked
    if [[ ! -e "$SRC" ]]; then
        ## Do nothing if it does not exist
        msg "$FgYellow" "  Source not found: $SRC"
        return
    fi
    sf=$(backupSubfolder "$1" "$2")   # Backup folder (Target directory)
    mkdir -p -m 0777 "$sf"
    resScript="$sf/restoreBackup.sh"
    if [[ ! -s "$resScript" ]]; then
        ## Put a little script in the folder that will restore a
        ## backup to the proper location
        echo "#!/bin/bash
## Function to restore a tar.gz backup to the location it came from
tgz=\"\$1\"
dest=\"$SRC\"
par=\$(dirname \"\$dest\")
if [[ -z \"\$tgz\" ]]; then
    echo \"Please pass the path to the tar.gz file as the first argument\"
    exit
fi
if [[ ! -s \"\$tgz\" ]]; then
    echo \"The provided file does not appear to exist:
    \$tgz
\"
    exit
fi

if [[ -d \"\$dest\" ]]; then
    ## If the target directory exists, move it to a renamed location (-BKUP)
    bkd=\"\$dest\"-BKUP
    if [[ -d \"\$bkd\" ]]; then
        echo \"Backup directory exists - please remove or rename and try again\"
        echo \"    \$bkd\"
        exit
    fi
    mv \"\$dest\" \"\$bkd\"
fi
## Create the partent directory if absent
[[ ! -d \"\$par\" ]] && mkdir \"\$par\"

echo \"
  Extracting: \$tgz
          To: \$par
\"
tar -C \"\$par\" -xvfz \"\$tgz\" 

if [[ ! -d \"\$dest\" ]]; then
    echo \"ERROR? Expected unpacked directory not found:
  \$dest
\"
else
    echo \"Files unpacked at:
  \$dest
\"
fi    

" > "$resScript"
        chmod 0775 "$resScript"
    fi
    mrb=$(mostRecentBackup "$1" "$2") # What is the most recent backup?
    if [[ ! -z "$mrb" ]]; then
        ## There is at least one backup. Is it more recent than the folder?
        bDt=$(lastModified "$mrb")
        fDt=$(lastModified "$SRC")
        if [[ "$bDt" > "$fDt" ]]; then
            # Do nothing if archive is fresh
            short=$(basename "$mrb")
            msg "$FgGreen" "  $short exists and is up-to-date for $SRC"
            return 
        fi
    fi
    tgz=$(date +"${datePattern}.tar.gz")
    ## Set up to avoid full directory path in tar file:
    Pwd=$(pwd)
    SrcPar=$(dirname "$SRC")
    SrcName=$(basename "$SRC")
    tgzPath="$sf/$tgz"
    cd "$SrcPar"
    msg "$FgCyan" "Backing up $SrcName"
    tar -czvf "$tgzPath" "$SrcName"
    ## Size of file: https://unix.stackexchange.com/a/16644
    sz=$(stat --printf="%s" "$tgzPath")
    sz=$(expr "$sz" / 1024)
    msg "$FgBlue" "  Backup complete - ${sz}kb\n    $tgzPath"
    cd "$Pwd" # Restore prior working directory
}

function rsyncFolder {
    ## $1 - The folder or file to archive
    ## $2 - Optional subfolder to put the archive under

    ## rsync reminders
    ##   -r, --recursive : recurse into directories
    ##   -l, --links : copy symlinks as symlinks
    ##   -p, --perms : preserve permissions
    ##   -t, --times : preserve modification times
    ##   -g, --group : preserve group
    ##   -o, --owner : preserve owner (super-user only)
    ##   --devices : preserve device files (super-user only)
    ##   --specials : preserve special files
    ##   -D : same as --devices --specials
    ##   -a : same as -rlptgoD (all the above)
    ##   -C, --cvs-exclude : auto-ignore files in the same way CVS does
    ##   -z, --compress : compress file data during the transfer

    
    SRC=$(readlink -f "$1")           # Source folder, de-linked
    [[ -e "$SRC" ]] || return         #   Do nothing if it does not exist
    sf=$(backupSubfolder "$1" "$2")   # Backup folder (Target directory)
    SrcName=`basename "$SRC"`

    msg "$FgCyan" "Synchronizing $SrcName"
    rsync -av "$SRC" "$sf"
}
