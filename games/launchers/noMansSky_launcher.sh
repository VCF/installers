#!/bin/bash

## Location of the executable:
PROGDIR="No Man's Sky"
LAUNCH="NMS.exe"
## Subdirectory in the program folder to change to before running:
PROGSUBDIR="Binaries"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_no_mans_sky_*.exe'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

###### configuration:
## Should we use 32- or 64-bit environment?
wineBits="64"
## Define the prefix (folder) for the Wine installation:
WINEPREFIX="$HOME/Wine$wineBits"
## Set the architecture being used for Wine:
WINEARCH="win$wineBits"
## The location of the installed program in drive_c:
WINETARGET="GOG Games/$PROGDIR"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

## Specify any required APT packages:
APTPACKAGES='winbind
mesa-vulkan-drivers
libvulkan1'

## Location of the programs save files / config:
INSTSAVEDIR="drive_c/users/$USER/Application Data/HelloGames/NMS"

## Custom function to run after installation:
function INSTFUNCTION {
    ## Vulkan pacakged with game does not work. Rename it to cause
    ## program to fall back to system's version of Vulkan:
    PDIR="$GAMEDIR/$PROGDIR/Binaries"
    GOOD="$PDIR/DO_NOT_USE_vulkan.dll"
    BAD="$PDIR/vulkan-1.dll"
    if [[ -e "$BAD" ]]; then
        mv "$BAD" "$GOOD"
        msg "$FgMagenta" "
Moved Vulkan DLL:
  From: $BAD
    To: $GOOD
"
    fi
    if [[ ! -e "$GOOD" ]]; then
        msg "$BgYellow;$FgRed" "
Failed to find properly named Vulkan DLL. It should be at:
  $GOOD
  ... but was not located.
"
        exit
    fi
}

## Notes shown before program is executed
PRERUN="
WineHQ Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=34056

Problem:
  I can't for the life of me get mouse and keyboard to correctly work.
  This behavior is seen on two systems (both Linux Mint 19.3)
  Mouse:
    Right mouse button ends up just being left mouse button
  Keyboard:
    'Sided' modifier keys (like 'Left Ctrl') are not recognized. Instead
    they are recognized as the 'unsided' version (eg 'Ctrl')

If you have this problem, and do not remap your controls, you will not be
able to progress the game. In particular, some dialogs do not recognize
'Esc' to exit, and require the right-mouse button to be remapped, or you
will be stuck in the dialog forever (base research, for example).

To fix this, open Options and remap controls. Find every unrecognized key
or button, and map it to something else.

Also, The Internet agrees that the GOG version has significant limitations
when launched without GOG Galaxy - You will be known only as 'Explorer' and
will not be able to participate in the community features. Multiplayer may
also be messed up.

Load times are REALLY long. Like 5 minutes long. Fortunately, you can work
in another application while loading occurs (eg a web browser). In order
to Alt-tab to other applications, you may need to change screen from
'Fullscreen' to 'Borderless Window'.
"

find_and_run_executable "$@"
