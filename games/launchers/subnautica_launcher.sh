#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Location of the executable:
PROGDIR="Subnautica"
LAUNCH="Steam.exe"

## Location of the installer:
INSTDIR="Other/Steam"
INSTNAME='SteamSetup.exe'

## Wine configuration:
wineBits="64"
WINEPREFIX="$GAMEDIR/$PROGDIR"Wine
WINEARCH="win$wineBits"
## https://old.reddit.com/r/subnautica/comments/75khp3/subnautica_on_linux_using_wine_staging_works_99/
WINEDEBUG="-all,fixme-all"
INSTTRICKS="corefonts vcrun2013"

## Installation post-processing:
## Capitalization may vary:
WINETARGET="Program Files (x86)/Steam"
# INSTSAVEDIR="drive_c/users/$USER/Application Data/WB Games/LEGO® Harry Potter™/SavedGames"

INSTICON="$PROGDIR.png"
## Notes:
PRERUN="
WineHQ Silver / Gold
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=37132
  https://appdb.winehq.org/objectManager.php?sClass=version&iId=36725&iTestingId=102645
  'run the game with the -force-glcore45 argument to run it natively on OpenGL'

"

function INSTFUNCTION {
    ## https://appdb.winehq.org/objectManager.php?sClass=version&iId=20680
    wineDriveC
    
    msg "$FgMagenta" "
Setting two registry keys...
"
    wine reg.exe ADD \
         "HKEY_CURRENT_USER\Software\Wine\AppDefaults\Steam.exe" \
         /v "Version" /t "REG_SZ" /d "winxp64" /f
    wine reg.exe ADD \
         "HKEY_CURRENT_USER\Software\Wine\AppDefaults\steamwebhelper.exe" \
         /v "Version" /t "REG_SZ" /d "winxp64" /f 

    msg "$FgMagenta" "
You will need to update the Steam launch options for subnautica to include:
  -force-glcore45
    ## OR:
  -force-opengl

After you authenticate to steam run the launcher again.

"
    exit
}

find_and_run_executable "$@"
