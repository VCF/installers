#!/bin/bash

## Location of the executable:
PROGDIR="Ultimate Doom"
## DosBox arguments - will generally be one or more conf files
DOSBOX='-conf "../dosbox_doom.conf" -conf "../dosbox_doom_single.conf" -noconsole -c "exit"'
## Just include an executable below. It won't be run, but this script
## will check for it to see if installation has already occured:
LAUNCH="../SETUP.EXE"
## Optional subdirectory of above file. Note that DosBox will also
## launch from that folder (in case it also has needed DLLs):
PROGSUBDIR="DOSBOX"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_the_ultimate_doom_*.exe'

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
WINETARGET="GOG Games/DOOM"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='
dosbox
'
## Location of the programs save files / config:
## INSTSAVEDIR="$HOME/.config/foobar"
##   Save files are in primary folder as DOOMSAV[0-9].DSG

find_and_run_executable "$@"
