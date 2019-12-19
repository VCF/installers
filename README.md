## General Utility Functions

Setting up this repository to be used as a submodule in other
repositories.

* [gitMoveByPatch.sh](gitMoveByPatch.sh) - git functions to excise
  part of a repo along with its history, and a reminder message of how
  to apply it to a new repo
* [.updateSubmodules.sh](.updateSubmodules.sh) - simple script that just runs
  `git submodule update --init --recursive --remote`

### Tech notes for [generalUtilities][gu] subtree

* Used for [_util_functions.sh][uf] - Basic functions, mostly
  colorized terminal messaging.
* [How to remove a submodule][smrm] and [how to add a subtree][stadd]

[gu]: https://github.com/VCF/generalUtilities
[uf]: https://github.com/VCF/generalUtilities/blob/master/_util_functions.sh
[smrm]: https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule/36593218#36593218
[stadd]: https://www.atlassian.com/git/tutorials/git-subtree
