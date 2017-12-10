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


function msg {
    >&2 echo -e "\033[1;$1m$2\033[0m";

}

function set_title {
    echo -ne "\033]0;$1\007";
}

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
    [[ -z "$TRIEDINSTALL" ]] && installGame
    
    # Nothing found in any of the paths:
    msg 31 "
Failed to find executable in $GAMEDIR
  Looked in: $PROGDIR
        For: $LAUNCH
"
    sleep 15
}

function installGame {
    TRIEDINSTALL="CHECKED"
    if [[ -z "$INSTDIR" || -z "$INSTNAME" ]]; then
        ## No information on where to find installer
        msg "31" "
No guidance given on where to find installer
  Consider setting INSTDIR and INSTNAME in the launcher
"
        echo ""
        return
    fi
    
    installer=`ls -1t "$INSTROOT"/"$INSTDIR"/$INSTNAME | head -n1`
    if [[ -z "$installer" ]]; then
        ## Installer not found
        msg 31 "  Could not find installer '$INSTNAME' in '$INSTDIR'"
        echo ""
        return
    fi

    cd "$GAMEDIR"
    
    isSH=`grep 'sh$' "$installer"`
    if [[ ! -z "$isSH" ]]; then
        TRIEDINSTALL="SHELL: $installer"
        if [[ -x "$installer" ]]; then
            msg "35" "
Preparing to install:
  $installer
  If asked for a location, use: $GAMEDIR
           Subfolder should be: $PROGDIR
"
            $installer
            find_and_run_executable
        else
            msg "31" "
Found installer:
  $installer
  ... but it is not executable. Run:
    chmod u+x "$installer"
"
        fi
    else
        msg "31" "
Found installer:
  $installer
  ... but did not know what to do with it.
"
        TRIEDINSTALL="UNKNOWN"
    fi
}
