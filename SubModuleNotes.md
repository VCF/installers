## Using a submodule

It seems normal to be confused by git submodules...

### Updating already-establish submodule

Via [@Henrik Gustafsson on StackOverflow][PullSub]:

```bash
## From the 'parent' repo:
git submodule update --recursive --remote
```

Suggestion from [Vogella][Vogella] did not appear to work; The
operation claimed submodule was "Already up-to-date", even though a
`git status` within the submodule indicated it was three commits
behind:

```bash
## Did not perform as expected:
git pull --recurse-submodules
```

### Cloning a repo with submodules

Via [Vogella][Vogella]:

```bash
## Not yet cloned at all:
git clone --recursive git@github.com:USERNAME/REPONAME.git

## Cloned the 'parent', but forgot the --recursive flag:
git submodule update --init --recursive
```

### First time usage

Via [@VonC on StackOverflow][FirstTime] (git >= 1.8.2):

```bash
cd /my/parent/repo
## Add (this) submodule *AND* track Master:
git submodule add -b master https://github.com/VCF/generalUtilities.git
# update
git submodule update --remote 
```

_Note_: You likely want to add the submodule using __HTTPS, not
SSH__. If you use SSH, all attempts to clone the repository will
demand valid SSH credentials

### Removing a submodule

Via [@VonC on StackOverflow](https://stackoverflow.com/a/16162000)

```bash
git submodule deinit -f -- a/submodule
rm -rf .git/modules/a/submodule
git rm -f a/submodule
```

### Advanced

There are options to have a submodule track specific branches or commits

[FirstTime]: https://stackoverflow.com/a/9189815
[Vogella]: http://www.vogella.com/tutorials/GitSubmodules/article.html
[PullSub]: https://stackoverflow.com/a/1032653
