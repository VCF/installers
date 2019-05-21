#!/bin/bash

## I find the UI path to suspending a system tedious. I'd like a
## script that can be put as a launcher in the panel and fired with
## one click. The way Debian-based systems put themselves to sleep /
## suspsend seems to change every two years. This script is designed
## to codify the different mechanisms

HNAME=`hostname`

# Thunderbird over NFS causes issues...
## killall --quiet --signal INT thunderbird

# Also shutdown any virtualbox instances:
## killall --quiet --signal INT VirtualBox

## Give the mouse time to settle down
sleep 2

HASGSC=`which gnome-screensaver-command`
HASPMI=`which pmi`
ISSYSTEMD=`which systemctl`

if [[ $HNAME != 'shrew' && ! -z "$HASGSC" ]]; then
    ## I forget why I wasn't doing this on shrew ...
    ## How do I lock the screen from a terminal?
    ##   https://askubuntu.com/a/184732
    echo "Lock via screensaver"
    gnome-screensaver-command -l &
    
elif [[ ! -z "$ISSYSTEMD" ]]; then
    ## https://askubuntu.com/a/780990
    echo "Sleep by systemctl"
    systemctl suspend -i
    
elif [[ ! -z "$HASPMI" ]]; then
    ## https://askubuntu.com/a/1795
    echo "Sleep by pmi"
    pmi action suspend
    
else
    echo "Sleep by dbus-send"
    dbus-send --system --print-reply \
              --dest="org.freedesktop.UPower" \
              /org/freedesktop/UPower \
              org.freedesktop.UPower.Suspend
    
fi

# How can I suspend/hibernate from command line?
# https://askubuntu.com/a/131022

#if [ $HNAME == 'badger' ]; then
#    # gnome-screensaver-command -l &
#    dbus-send --type=method_call --dest=org.gnome.ScreenSaver \
#        /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
#fi

echo "Waking up at " `date`

sleep 5
