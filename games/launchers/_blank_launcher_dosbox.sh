#!/bin/bash

## Location of the executable:
PROGDIR="Name of Directory After Installation"
## DosBox arguments - will generally be one or more conf files
DOSBOX='-conf ../foo.conf -conf ../bar.conf -fullscreen -noconsole -c exit'
## Just include an executable below. It won't be run, but this script
## will check for it to see if installation has already occured:
LAUNCH="someRandomExecInFolder.exe"
## Optional subdirectory of above file. Note that DosBox will also
## launch from that folder (in case it also has needed DLLs):
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='installer_file_name_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### Wine settings for installer ######
## The target of this installer does not run on Wine per se, but the
## installer itself does. That is, the installer is a Windows
## executable that installs a DosBox application. So we still need
## Wine configuration for the installer.

## Should we use 32- or 64-bit environment?
wineBits="32"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="Program Files/Foo Bar"
## Any winetricks that might be needed:
## INSTTRICKS="d3dx9_43 wmp9 wmp10"
## Switches passed to Wine when running application
## WINEARGS="-windowed"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='
dosbox
'
## Normally a new terminal is opened to launch. Flag to prevent this:
## NOTINTERM="No launching terminal"

## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
## Flag to use if backup should use rsync rather than tar/gzip:
## DORSYNC="yes"
## Flag that prevents backups if set, and shows the provided message:
## NOAUTOBACK="Backups take too long to run"

## Custom function to run after installation:
#function INSTFUNCTION {
#  echo "For example, properly setting executable bits"
#}
## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
#PRERUN="
#If the program asks to choose a flavor, please select 'Tepid Mango'
#"

find_and_run_executable "$@"
