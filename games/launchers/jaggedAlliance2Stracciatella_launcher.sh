#!/bin/bash

## Location of the executable:
SNAME="Jagged Alliance 2 Stracciatella"
PROGDIR="$SNAME"
LAUNCH="whatActuallyRunsTheProgram.sh"
## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## git repository path:
00INSTGIT="https://github.com/ja2-stracciatella/ja2-stracciatella.git"

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='rustc cargo'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Notes shown before the installer program runs
#PREINST="
#  Any message you want the installer to display before running, eg
#  Be sure to uncheck the box 'send details to NSA'
#"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run after installation:
function INSTFUNCTION {
    ## Needs CMake >= 3.18.1
    cd "$GAMEDIR/$PROGDIR"
    mkdir _bin && cd _bin   
    msg "$FgMagenta" "
Compiling $PROGDIR in '$(pwd)'
"
    cmake ../
    make
}
## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
#PRERUN="
#  Any message you want the program to display before running
#"

find_and_run_executable "$@"
