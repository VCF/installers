#!/bin/bash

## Location of the executable:
PROGDIR="Men of War"
LAUNCH="notSure.sh"

## Location of the installer:
INSTDIR="GOG/$PROGDIR"
INSTNAME='setup_men_of_war_red_tide_*.exe'

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

echo "Looks like this installer wasn't finished ..."

# https://appdb.winehq.org/objectManager.php?sClass=version&iId=13652&iTestingId=31418#viewHowTo

