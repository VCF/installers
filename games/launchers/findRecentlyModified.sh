#!/bin/bash

## Find recently (24hr) modified files in home directory, filtering
## out irrelevant matches

find "$HOME" -mtime -1 |\
    egrep -v '(Wine|waterfox|gimp|cache|Browser|confFiles|emacs)' |\
    egrep -v '(Desktop|Programs|icons|GameFiles|zeitgeist|generalUtilities)' |\
    egrep -v '(installers|pulse|Downloads|Trash|QMapShack|dolphin)' |\
    egrep -v '(RecentDocuments|kactivitymanagerd)' |\
    less -S
