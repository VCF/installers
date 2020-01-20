#!/bin/bash

## Repo's wine version is generally horrendously behind. Install wine
## from WineHQ's remote.

## Source Utility functions
my_dir="$(dirname "$0")"
. "$my_dir/_launcher_functions.sh"

msg "$FgMagenta" "Getting WineHQ PPA Key"
wget -nc https://dl.winehq.org/wine-builds/Release.key

msg "$FgBlue$BgYellow" "Adding WineHQ PPA - you may be asked for sudo password"
sudo apt-key add Release.key

## Get your ubuntu 'codename' for your operating system
distributor=`lsb_release -is`
if [[ "$distributor" == 'LinuxMint' ]]; then
    debCodeName=`grep DISTRIB_CODENAME /etc/upstream-release/lsb-release | sed 's/.*=//'`
else
    debCodeName=`lsb_release -cs` ## Eg 'xenial' or 'sylvia'
fi

if [[ -z "$debCodeName" ]]; then
    msg "$FgRed$BgYellow" "Failed to determine your release 'codename' (eg 'Xenial')"
else
    ## Add the WineHQ repository, update repository manifest, note you
    ## want i386 libraries, install wine with all recommended packages
    msg "$FgGreen" "Installing most recent wine for Debian $debCodeName"
    sudo apt-add-repository \
         "deb https://dl.winehq.org/wine-builds/ubuntu/ $debCodeName main"
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install --install-recommends winehq-stable
fi

msg "$FgGreen" "Installation complete"
