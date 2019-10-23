#!/bin/bash

## Location of the executable:
PROGDIR="ImageJ"
LAUNCH="ij.jar"
JAVACMD="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"
## Location of the installer:
APTPACKAGES="openjdk-8-jre"
INSTDIR="OpenSource/$PROGDIR"
INSTNAME='ij*-linux64-java8.zip'
INSTICON="$PROGDIR.png"

## Can't find any settings directory?
# INSTSAVEDIR="$HOME/.foo"

my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

find_and_run_executable "$@"

## Minecraft apparently needs JRE 8
##   https://askubuntu.com/a/1030255
##   I can confirm it failed with 11, but worked for 8 (Ubuntu 18.04.2 LTS)
