#!/bin/bash

GAMEDIR="$HOME/Programs"
LOGFILE="LaunchLog.txt"
INSTROOT="/abyss/Installers"

## Library of functions used to install and launch games. Installed
## games are expected to be in $GAMEDIR (above). Launching will look
## for two environment variables:

##   $PROGDIR - The first-level subdirectory of $GAMEDIR
##   $LAUNCH  - The name of the executable (can include additional subdirs)

## If the file is found:
##   * If it is executable, it will be launched.
##   * If it is a Java .jar file, it will be launched with java
## In both cases STDOUT will be captured in $LOGFILE (above), written
## to $PROGDIR

## If the launcher is not found, then the installer directory
## $INSTROOT (above) will be checked to see if the instal file
## $INSTNAME can be found in directory $INSTDIR. If those variables
## are set and the installer is found:
##   * If it is a .sh it will be run
##   * If a .bz2/bzup2 it will be extracted


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

## Load the general utility functions, held in the same repo
my_dir="$(dirname "$0")"
. "$my_dir/../../systemSetup/_util_functions.sh"


# Testing the suffix of a file:
# https://stackoverflow.com/a/965072

function find_and_run_executable {
    if [[ ! -d "$GAMEDIR" ]]; then
        msg "31" "
Game directory not found, expected at:
  $GAMEDIR
  This can be a symlink, if desired.
"
        sleep 15
        return
    fi
    
    EXECUTABLE="$GAMEDIR/$PROGDIR/$LAUNCH";
    LOG="$GAMEDIR/$PROGDIR/$LOGFILE";
    if [ -x "$EXECUTABLE" ]; then
        msg 32 "  Running $EXECUTABLE"
        cd "$GAMEDIR/$PROGDIR";
        # Set terminal title:
        # https://unix.stackexchange.com/a/11230
        set_title "Run $PROGDIR";
        "./$LAUNCH" &> "$LOG"
        msg 36 "  Launcher finished. Logfile:\n    less -S \"$LOG\"";
        echo "";
        sleep 15
        return
    elif [ -s "$EXECUTABLE" ]; then
        ## Not an executable. What is the extension?
        ##     https://stackoverflow.com/a/965069
        ext="${LAUNCH##*.}"
        if [ "$ext" = 'jar' ]; then
            msg 32 "  Running Java file \"$EXECUTABLE\""
            cd "$GAMEDIR/$PROGDIR";
            set_title "Run $PROGDIR";
            java -Xmx1024M -Xms1024M -jar "$LAUNCH" &> "$LOG"
            msg 36 "  Launcher finished. Logfile:\n    less -S \"$LOG\"";
            echo "";
            sleep 15
            return
        else
            msg 31 "  Command exists but is not executable:\n    \"$EXECUTABLE\""
        fi
    fi

    ## Nothing found. Can we install?
    if [[ -z "$TRIEDINSTALL" ]]; then
       installGame
       return
    fi
    
    ## Nothing found in any of the paths:
    msg 31 "
Failed to find executable in $GAMEDIR
  Looked in: $PROGDIR
        For: $LAUNCH
"
    sleep 15
}

function installGame {
    TRIEDINSTALL="CHECKED"
    if [[ -z "$INSTNAME" ]]; then
        ## No information on where to find installer
        msg "31" "
No guidance given on where to find installer
  Consider setting INSTDIR and INSTNAME in the launcher
"
        echo ""
        return
    fi
    findInstaller
        
    if [[ -z "$installer" ]]; then
        ## Installer not found
        msg 31 "  Could not find installer '$INSTNAME' in:
${TryDir[@]}"
        echo ""
        return
    fi

    cd "$GAMEDIR"
    determineSuffix

    if [[ $sfx == "sh" ]]; then
        TRIEDINSTALL="SHELL: $installer"
        if [[ -x "$installer" ]]; then
            installShell
        else
            failedNotExecutable
            return
        fi
    elif [[ $sfx == "bz2" || $sfx == "bzip2" ]]; then
        ## bzip archive
        installBzip
    elif [[ $sfx == "gz" ]]; then
        ## gzip archive
        installGzip
    else
        ## No idea!
        failedUnknown
        return
    fi

    autoRename
    
    msg "30;102" "
Installer finished, attempting launch
  If successful, be sure to also link save files to consistent location:
  ~/confFiles/games/makeGameLinks.sh
"
    showComments
    find_and_run_executable
}

function findInstaller {
    ## Check first to see if the installer is in ~/Downloads or
    ## ~/ToFile; If so, use one of those.
    TryDir[0]="$HOME/Downloads"
    TryDir[1]="$HOME/ToFile"
    if [[ ! -z "$INSTDIR" ]]; then
        ## Also use INSTDIR as default location, if it has been set by
        ## the launcher
        isAbsPath=`echo "$INSTDIR" | grep '^/'`
        if [[ -z "$isAbsPath" ]]; then
            ## Appears to be a relative path
            TryDir[2]="$INSTROOT"/"$INSTDIR"
        else
            ## Appears to be an absolute path
            TryDir[2]="$INSTDIR"
        fi
    fi

    for dir in "${TryDir[@]}"; do
        ## List by modified date, if there are more than one match
        ## take the most recent one. Allows use of pattern eg:
        ##    myGame_*.sh -> myGame_1.3.sh, myGame_1.4.2.sh etc
        installer=`ls -1t "$dir"/$INSTNAME 2>/dev/null | head -n1 `
        [[ -z "$installer" ]] || break # Take first example we find
    done
}

function determineSuffix {
    ##  Lower case in bash: https://stackoverflow.com/a/2264537
    ## Parameter Expansion: https://stackoverflow.com/a/965069
    sfx=`echo "${installer##*.}" | tr '[:upper:]' '[:lower:]'`
    ## Also see if this looks like a TAR archive
    unTar=`isTarArchive "$installer"`
}

function isTarArchive {
    isTar=`echo "$1" | grep -i '\.tar\.'`
    unTarLine=""
    [[ -z "$isTar" ]] || unTarLine=" | tar -xvf -"
    echo "$unTarLine"
}

function installShell {
    msg "35" "
Preparing to install:
  $installer
  If asked for a location, use: $GAMEDIR
           Subfolder should be: $PROGDIR
"
    $installer
}

function installBzip {
    TRIEDINSTALL="BZIP2 Archive: $installer"
    msg "35" "
Preparing to extract:
  $installer
"
    ## Extracting Bzip: https://superuser.com/a/480951
    cmd="bzip2 --stdout --verbose --decompress --keep \"$installer\" $unTar"
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function installGzip {
    TRIEDINSTALL="GZIP Archive: $installer"
    msg "35" "
Preparing to extract:
  $installer
"
    ## Extracting Bzip: https://superuser.com/a/480951
    cmd="gzip --stdout --verbose --decompress --keep \"$installer\" $unTar"
    ## Command literal with eval: https://stackoverflow.com/a/2355242
    eval "$cmd"
}

function failedNotExecutable {
    msg "31" "
Found installer:
  $installer
  ... but it is not executable. Run:
    chmod u+x "$installer"
"
}

function failedUnknown {
    msg "31" "
Found installer:
  $installer
  ... but did not know what to do with it.
"
    TRIEDINSTALL="UNKNOWN"
}

function showComments {
    ## Indicate if additional packages are indicated as needed:
    [[ -z "$INSTAPT" ]] || msg "43;34" "
You may need to install additional libraries / software using:
    sudo apt install $INSTAPT"

    ## Indicate if help (URL, man page, etc) is provided:
    [[ -z "$INSTHELP" ]] || msg "36" "Installation Help: $INSTHELP"
    
}

function autoRename {
    [[ -z "INSTRENAME" ]] && return
    ## A variable has been set to rename something. This can be useful
    ## when an archive has a generic name like 'linux' as the
    ## top-level folder
    
    ## String splitting: https://stackoverflow.com/a/918931
    IFS='/' read -ra RenameBits <<< "$INSTRENAME"
    reFrom="${RenameBits[0]}"
    reTo="${RenameBits[1]}"
    
    if [[ -z "$reFrom" || -z "$reTo" ]]; then
        msg "31" "
The variable INSTRENAME was set, indicating that something should be renamed
  But I only found one part (there should be two separated by '/'):
    $INSTRENAME
  This may cause problems ...
"
        return
    fi

    if [[ ! -e "$reFrom" ]]; then
        msg "31" "
Rename request
  From: \"$reFrom\"
    To: \"$reTo\"
  But I could not find \"$reFrom\" ...
  This may cause problems ...
"
        return
    fi

    if [[ -e "$reTo" ]]; then
        msg "31" "
Rename request
  From: \"$reFrom\"
    To: \"$reTo\"

  But \"$reTo\" already exists! Please resolve (renaming, moving
  or deleting the 'To' file), this will almost certainly cause
  problems!
"
        return
    fi

    ## We have identified the "from" file, and the "to" file does not
    ## exist. Rename it:
    mv "$reFrom" "$reTo"
    msg "32" "Renamed '$reFrom' to '$reTo'"
}
