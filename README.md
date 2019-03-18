## General Utility Functions

Setting up this repository to be used as a submodule in other
repositories.

* [gitMoveByPatch.sh](gitMoveByPatch.sh) - git functions to excise
  part of a repo along with its history, and a reminder message of how
  to apply it to a new repo
* [.updateSubmodules.sh](.updateSubmodules.sh) - simple script that just runs
  `git submodule update --init --recursive --remote`

### Moved to [generalUtilities][gu] submodule


* [_util_functions.sh][uf] - Basic functions, mostly
  colorized terminal messaging.

[gu]: https://github.com/VCF/generalUtilities
[uf]: https://github.com/VCF/generalUtilities/blob/master/_util_functions.sh
