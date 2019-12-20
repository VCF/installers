#!/usr/bin/env bash

## Detailed description of this file is at the end ...

## If this file is not in your home directory and called
## .vcfInstallerPrefs.sh then it is a template, not the settings file

######## SETTINGS ########

##---------------------------------------------------------------------
## INSTROOT is where you keep your installer files. You need to
## provide at least one location, but you can provide others. Each
## location should be on its own line. The scripts will look in each
## location in order, and take the first matching installer file they
## find
INSTDIRS="
$HOME/Downloads
/harmless/example/myinstallers
/harmless/other/example/acmeSoftware
"
## (The default is simply your 'Downloads' folder. It is strongly
##  advised that you keep your installers in a more permanent
##  location. The other two 'harmless examples' illustrate how to
##  include multiple directories. You can safely remove or replace them)


##---------------------------------------------------------------------
## ICONDIRS is one or more folders where game icons can be
## found. These icons will be used to make the desktop launchers for
## you.
ICONDIRS="
$HOME/Downloads
"
## (The default is again your 'Downloads' folder. It is probably wise
##  to have a more stable folder to hold them. See INSTROOT above for
##  how to include multiple directories, if desired.)


##---------------------------------------------------------------------
## BACKUPDIR is where your tar.gz backups will be stored. This starts
## unset (empty quotes) which will create a default location in your
## home dir. You probably will want to set a custom location:
BACKUPDIR=""


##---------------------------------------------------------------------
## GAMEDIR is where the programs will be installed (not only for
## games, any program you install with the tool)
GAMEDIR="$HOME/Programs"

##---------------------------------------------------------------------
## SAVEDIR is where configuration or saved files will be moved. The
## folder will be created if it does not already exist
SAVEDIR="$HOME/Documents/GameFiles"

##---------------------------------------------------------------------
## The logfile will capture STDOUT (shell output) when the program
## runs. It will be written inside each program's directory in GAMEDIR:
LOGFILE="LaunchLog.txt"


## If you don't want to be reminded about this file location, comment
## out the line below (put a '#' at the front):
echo "Configuration file read: ${BASH_SOURCE[0]}"


######## HELP ########

whatIsThisFile="

Short answer: Configuration settings for a set of software installation scripts

Details:

This is a configuration file used by the installers repository:

https://github.com/VCF/installers

... a package of scripts designed to standardize the installation of
software on Linux systems. Most of the scripts install games, though
there are some other applications as well. Each script generally will
do the following tasks:

* Find the installation file
* Determine how the installer works
  * Simple unpacking of a tar.gz or zip file?
  * Direct linux installation?
  * Wine install of a windows executable?
* Run the installation file (hopefully sucessfully installing the software)
* Perform needed/desired tweaks:
  * Set programs to be executable?
  * Check for required packages and install if neccesary?
* Standardize the location of save directories for you
  * For example, configuration settings or game progress files
  * This is to help you backup files, or transfer to new hardware
* Create a desktop launcher for you
  * Launchers create a log file for the most recent run
  * Any program with identified save/configuration folders will have a
    backup .tar.gz archive made for each run (one per day)

What the scripts DO NOT do:

* They do NOT contain the installers themselves. You need to acquire them!
  * A few are part of standard repositories
  * Some are open source, or otherwise free
  * Most are available for purchase from sources like GOG or Humble Bundle
* They do NOT provide launcher icons
  * The copyright status of the icons is often unclear, so I won't include them
  * You can find these yourself with online image search tools
  * You will be told where the icon should be saved
* They will NOT magically make your files safe!
  * Config/save files are centralized where you can easily find them
  * tar.gz backups are made after each run ... but *they* should get backed up!
  * It is still up to you to assure that any that are important to you
    are adequately preserved to your satisfaction
  * HAVE A FILE BACKUP STRATEGY (for -all- your files!)
    https://goinglinux.com/articles/Backups.html

"
