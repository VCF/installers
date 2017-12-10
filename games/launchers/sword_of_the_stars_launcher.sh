#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"


set_title "Sword of the Stars";

msg 32 "  Running $EXECUTABLE"

env WINEPREFIX="$HOME/.wine_sots" wine explorer /desktop=SotS,1920x1080 \
    C:\\windows\\command\\start.exe /Unix \
    $HOME/.wine_sots/dosdevices/c:/users/Public/Desktop/Sword\ of\ the\ Stars.lnk

msg 36 "  Launcher finished."
