#!/bin/bash

## Git repositories installed on almost every system:

echo "
Cloning git repositories
  You can ignore 'fatal: destination path' errors, they simply indicate that
  the repo has already been cloned
"

cd "$HOME"

## Utility methods
git clone git@vcf.github.com:VCF/generalUtilities.git

## Helper apps and scripts
git clone git@vcf.github.com:VCF/Helpers.git

## Software installer framework
git clone --recursive git@vcf.github.com:VCF/installers.git

## Correct Battery Horse Staple password aid
git clone git@vcf.github.com:VCF/RandomWordList.git

## Configuration scripts and settings
git clone --recursive git@maptracker.github.com:maptracker/confFiles.git
