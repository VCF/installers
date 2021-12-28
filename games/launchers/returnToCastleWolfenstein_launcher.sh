#!/bin/bash

## Location of the executable:
PROGDIR="Return to Castle Wolfenstein"
LAUNCH="WolfSP.exe"
## NOTE: Multiplayer is apparently WolfMP.exe

## Arguments to pass to the executable when running:
## LAUNCHARGS="-nogui -res=640x320"
## Subdirectory in the program folder to change to before running:
## PROGSUBDIR="bin"

## Location of the installer on your file system:
INSTDIR="GOG/Wolfenstein"
INSTNAME='setup_return_to_castle_wolfenstein_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

msg "$BgYellow;$FgRed" "

Could not get '$PROGDIR' working.

On the PN-40 at least it appears to be a problem with video
drivers? Might be resolvable.

"
# exit

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="32"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/$PROGDIR"
## Any winetricks that might be needed:
## INSTTRICKS="d3dx9_43 wmp9 wmp10"
## Switches passed to Wine when running application
LAUNCHARGS="/SP- /NOCANCEL /SUPPRESSMSGBOXES"

## Filename of launcher icon (looks in default folders):
INSTICON="Wolfenstein.png"

## Specify any required APT packages:
APTPACKAGES='libvulkan-dev:i386'
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
PRERUN="
  WineHQ: https://appdb.winehq.org/objectManager.php?sClass=application&iId=501
  Lutris script: https://lutris.net/games/install/2658/view
"

## export __GL_ExtensionStringVersion=17700
find_and_run_executable "$@"
