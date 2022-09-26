#!/bin/bash

## Location of the executable:
PROGDIR="Minecraft"
LAUNCH="/usr/bin/minecraft-launcher"

## Location of the installer on your file system:
INSTDIR="Minecraft"
INSTNAME="Minecraft.deb"

## JRE 8 needed:
#APTPACKAGES="openjdk-8-jre"
#INSTHELP="To update, visit: https://minecraft.net/download
##"



## Installation post-processing:
INSTSAVEDIR="$HOME/.minecraft/saves"
INSTICON="minecraft_logo1.png"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

## Minecraft apparently needs JRE 8
##   https://askubuntu.com/a/1030255
##   I can confirm it failed with 11, but worked for 8 (Ubuntu 18.04.2 LTS)
