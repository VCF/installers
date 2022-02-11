#!/bin/bash

## Location of the executable:
PROGDIR="FA Angband"
LAUNCH="src/faangband"
## Arguments to pass to the executable when running:
## suboption -n8 will open 8 sub-windows
LAUNCHARGS="-mx11 -- -n8"

## Location of the installer on your file system:
INSTDIR="GOG/$PROGDIR"
INSTNAME='FAangband-*.tar.gz'

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

## Filename of launcher icon (looks in default folders):
INSTICON="$PROGDIR.png"

###### Unpacking optionos
## Rename the default install directory to something else:
INSTRENAME='FAangband-*/'$PROGDIR

## Location of the programs save files / config:
INSTSAVEDIR="$GAMEDIR/$PROGDIR/lib/save"

function RUNFUNCTION {
    ## Font size of windows are controlled thru environment values
    ## https://angband.readthedocs.io/en/latest/customize.html

    msg "$FgGreen" "
Setting sub-window placement
"

    ## Main Window 
    export ANGBAND_X11_FONT_0='8x13'
    export ANGBAND_X11_AT_X_0=488
    export ANGBAND_X11_AT_Y_0=1
    export ANGBAND_X11_COLS_0=116
    export ANGBAND_X11_ROWS_0=80

    ## 1: Messages 
    export ANGBAND_X11_FONT_1='6x9'
    export ANGBAND_X11_AT_X_1=1
    export ANGBAND_X11_AT_Y_1=1
    export ANGBAND_X11_COLS_1=80
    export ANGBAND_X11_ROWS_1=50
    
    ## 2: Equipment / Inventory 
    export ANGBAND_X11_FONT_2='8x13'
    export ANGBAND_X11_AT_X_2=1440
    export ANGBAND_X11_AT_Y_2=1
    export ANGBAND_X11_COLS_2=60
    export ANGBAND_X11_ROWS_2=26
    
    ## 3: Visible Monsters 
    export ANGBAND_X11_FONT_3='8x13'
    export ANGBAND_X11_AT_X_3=1
    export ANGBAND_X11_AT_Y_3=705
    export ANGBAND_X11_COLS_3=60
    export ANGBAND_X11_ROWS_3=24

    ## 4: Visible Items 
    export ANGBAND_X11_FONT_4='8x13'
    export ANGBAND_X11_AT_X_4=1
    export ANGBAND_X11_AT_Y_4=510
    export ANGBAND_X11_COLS_4=60
    export ANGBAND_X11_ROWS_4=12

    ## 5: Monster Recall
    export ANGBAND_X11_FONT_5='7x13'
    export ANGBAND_X11_AT_X_5=1570
    export ANGBAND_X11_AT_Y_5=390
    export ANGBAND_X11_COLS_5=50
    export ANGBAND_X11_ROWS_5=20
    
    ## 6: Map Overview
    export ANGBAND_X11_FONT_6='5x7'
    export ANGBAND_X11_AT_X_6=1440
    export ANGBAND_X11_AT_Y_6=700
    export ANGBAND_X11_COLS_6=95
    export ANGBAND_X11_ROWS_6=50
    
    ## 7: Character Info
    export ANGBAND_X11_FONT_7='8x13'
    export ANGBAND_X11_AT_X_7=1440
    export ANGBAND_X11_AT_Y_7=390
    export ANGBAND_X11_COLS_7=15
    export ANGBAND_X11_ROWS_7=20

}

## Custom function to run after installation:
function INSTFUNCTION {
    cd "$GAMEDIR/$PROGDIR"
    
    ## Compile
    if [[ -s "$LAUNCH" ]]; then
        msg "$FgCyan" "Main game engine has already been compiled"
    else
        msg "$FgMagenta;$BgYellow" "  ---- COMPILING $PROGDIR ----  "

        ./configure --with-no-install
        make
        
        if [[ -s "$LAUNCH" ]]; then
            msg "$FgGreen" "  Apparently succesful compilation"
        else
            msg "$FgRed;$BgYellow" "  Could not find launcher: $LAUNCH  "
        fi

    fi
}


## Custom function to run each time just before running the program:
#function RUNFUNCTION {
#  echo "For example, configuring the system in some way"
#}

## Notes shown before program is executed
PRERUN="
'First Age' Angband
  https://nickmcconnell.github.io/FAangband/description.html
  https://github.com/NickMcConnell/FAangband
  http://www.roguebasin.com/index.php/FAangband

Saves do not backup the configuration folder found at:
  '$HOME/.angband/FAangband'

"

find_and_run_executable "$@"
