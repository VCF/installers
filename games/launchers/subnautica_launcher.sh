#!/bin/bash

## Location of the executable:
PROGDIR="Subnautica"
LAUNCH="Steam.exe"
## https://store.steampowered.com/app/264710/Subnautica/
##   So far not getting Steam to auto-launch the app
LAUNCHARGS="-no-cef-sandbox -applaunch 264710 -force-glcore45"

## Location of the installer:
INSTDIR="Other/Steam"
INSTNAME='SteamSetup.exe'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

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
## WINEARGS="/nogui" # Get extra screen realestate
INSTSAVEDIR="drive_c/Program Files (x86)/Steam/steamapps/common/Subnautica/SNAppData/SavedGames"

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


    cFile="$cDrive/Program Files (x86)/Steam/config/config.vdf"
    if [[ -z $(grep '"CS"' "$cFile") ]]; then
        ## Need to add the content URLs to the steam config file
        ##   Otherwise was getting error ""
        ## https://old.reddit.com/r/wine_gaming/comments/8r0gh6/steam_in_winedevel_content_servers_unreachable/e0riqd9/

        msg "$FgMagenta" "
Adding explicit content domain names to config file:
  $cFile
"
        ## Make a copy of the conf file before modifying it
        bkup="$cFile"-BACKUP
        [[ -s "$bkup" ]] || cp "$cFile" "$bkup"

        ## Insert line into middle of file with sed
        ##   https://stackoverflow.com/a/6739322
        sed -n 'H;${x;s/^\n//;s/"cip" .*$/    "CS" "valve511.steamcontent.com;valve501.steamcontent.com;valve517.steamcontent.com;valve557.steamcontent.com;valve513.steamcontent.com;valve535.steamcontent.com;valve546.steamcontent.com;valve538.steamcontent.com;valve536.steamcontent.com;valve530.steamcontent.com;valve559.steamcontent.com;valve545.steamcontent.com;valve518.steamcontent.com;valve548.steamcontent.com;valve555.steamcontent.com;valve556.steamcontent.com;valve506.steamcontent.com;valve544.steamcontent.com;valve525.steamcontent.com;valve567.steamcontent.com;valve521.steamcontent.com;valve510.steamcontent.com;valve542.steamcontent.com;valve519.steamcontent.com;valve526.steamcontent.com;valve504.steamcontent.com;valve500.steamcontent.com;valve554.steamcontent.com;valve562.steamcontent.com;valve524.steamcontent.com;valve502.steamcontent.com;valve505.steamcontent.com;valve547.steamcontent.com;valve560.steamcontent.com;valve503.steamcontent.com;valve507.steamcontent.com;valve553.steamcontent.com;valve520.steamcontent.com;valve550.steamcontent.com;valve531.steamcontent.com;valve558.steamcontent.com;valve552.steamcontent.com;valve563.steamcontent.com;valve540.steamcontent.com;valve541.steamcontent.com;valve537.steamcontent.com;valve528.steamcontent.com;valve523.steamcontent.com;valve512.steamcontent.com;valve532.steamcontent.com;valve561.steamcontent.com;valve549.steamcontent.com;valve522.steamcontent.com;valve514.steamcontent.com;valve551.steamcontent.com;valve564.steamcontent.com;valve543.steamcontent.com;valve565.steamcontent.com;valve529.steamcontent.com;valve539.steamcontent.com;valve566.steamcontent.com;valve165.steamcontent.com;valve959.steamcontent.com;valve164.steamcontent.com;valve1611.steamcontent.com;valve1601.steamcontent.com;valve1617.steamcontent.com;valve1603.steamcontent.com;valve1602.steamcontent.com;valve1610.steamcontent.com;valve1615.steamcontent.com;valve909.steamcontent.com;valve900.steamcontent.com;valve905.steamcontent.com;valve954.steamcontent.com;valve955.steamcontent.com;valve1612.steamcontent.com;valve1607.steamcontent.com;valve1608.steamcontent.com;valve1618.steamcontent.com;valve1619.steamcontent.com;valve1606.steamcontent.com;valve1605.steamcontent.com;valve1609.steamcontent.com;valve907.steamcontent.com;valve901.steamcontent.com;valve902.steamcontent.com;valve1604.steamcontent.com;valve908.steamcontent.com;valve950.steamcontent.com;valve957.steamcontent.com;valve903.steamcontent.com;valve1614.steamcontent.com;valve904.steamcontent.com;valve952.steamcontent.com;valve1616.steamcontent.com;valve1613.steamcontent.com;valve958.steamcontent.com;valve956.steamcontent.com;valve906.steamcontent.com"\n&/;p;}' "$bkup" > "$cFile"
    fi

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
