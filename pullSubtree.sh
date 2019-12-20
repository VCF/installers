#!/usr/bin/env bash

## Bah. Subtrees don't recall where they are from. This just codifies
## the repository remote for generalUtilities

git subtree pull --prefix generalUtilities \
    https://github.com/VCF/generalUtilities.git master --squash
