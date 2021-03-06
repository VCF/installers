#!/bin/bash

## I find the UI path to suspending a system tedious. I'd like a
## script that can be put as a launcher in the panel and fired with
## one click. The way Debian-based systems put themselves to sleep /
## suspsend seems to change every two years. This script is designed
## to codify the different mechanisms

HNAME=$(hostname)

## On past systems, active instances of Thunderbird (with mail files
## on an NFS server) or VirtualBox caused problems when suspending, so
## I killed them. That seems to be resolved now. Leaving for posterity:

## killall --quiet --signal INT thunderbird
## killall --quiet --signal INT VirtualBox

echo "Suspend request at $(date)"
## Give the mouse time to settle down
sleep 2

HASGSC=$(which gnome-screensaver-command)
HASCSC=$(which cinnamon-screensaver-command)
HASMSC=$(which mate-screensaver-command)
HASPMI=$(which pmi)
ISSYSTEMD=$(which systemctl)

## If you also wish the computer to lock, place a non-empty file (any
## content) at this location:
doLockFile="$HOME/.lockOnSuspend"

if [[ -s "$doLockFile" ]]; then
    ## Locking the screen ...
    echo "Request to lock screen indicated by file: $doLockFile"
    ## ... but this ALSO is polymorphic across Ubuntu variants. Sigh.
    ##   https://forums.linuxmint.com/viewtopic.php?t=307131
    LockCommand=""
    if [[ -n "$HASGSC" ]]; then
        ## Gnome-based screensaver
        LockCommand="$HASGSC"
    elif [[ -n "$HASCSC" ]]; then
        ## Still Gnome, but Linux Mint, Cinnamon variant
        LockCommand="$HASCSC"
    elif [[ -n "$HASMSC" ]]; then
        ## Linux Mint, Mate variant
        LockCommand="$HASMSC"
    fi
    ## Did we find one?
    if [[ -n "$LockCommand" ]]; then
        echo "  Locking via $LockCommand"
        "$LockCommand" --lock &
    else
        echo "  Locking failed - appropriate lock commnand not identified!"
    fi
else
    echo "No locking requested. If you wish to also lock on suspend, create:
  $doLockFile
... with any content (at least one character)"
fi

if [[ -n "$ISSYSTEMD" ]]; then
    ## https://askubuntu.com/a/780990
    echo "Sleep by systemctl"
    systemctl suspend -i

    ## Sigh. Sometimes something weird happens and systemd gets locked
    ## up trying to sleep. The system will not suspend, and attempts
    ## to try again will report:
    
    ## Failed to suspend system via logind: There's already a shutdown
    ## or sleep operation in progress

    ## Poettering blames something other than systemd and WONTFIX:
    ##   https://github.com/systemd/systemd/issues/1640

    ## Fortunately we can check, and fix, if this happens:
    ##   https://unix.stackexchange.com/a/579531

    sssPID=$(systemctl list-jobs | grep systemd-suspend.service | grep '^([0-9]+)')
    if [[ -n "$sssPID" ]]; then
        echo "

It looks like systemctl may have failed to suspend the system?  If you
attempted to sleep and the system did not, and now won't sleep at all,
try:

  systemctl cancel $sssPID

... and run this script again

"
    fi
    
elif [[ -n "$HASPMI" ]]; then
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

echo "Waking up at $(date)"
