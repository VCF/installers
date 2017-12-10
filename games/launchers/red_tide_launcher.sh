#!/bin/bash

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

# https://appdb.winehq.org/objectManager.php?sClass=version&iId=13652&iTestingId=31418#viewHowTo

cd "$HOME/.wine/drive_c/GOG Games/Men of War - Red Tide"

wine SporeBin/SporeApp.exe -safe

