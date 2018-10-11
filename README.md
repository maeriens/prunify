# git-prunify - Trim your git tree from broken branches

A small bash script for cleaning your local repository of orphaned branches :fallen_leaf:

Clone it, chmod it, copy it.

## Installation

As a git custom command (Recommended):

- Clone the repo
- Make it executable with `chmod +x git-prunify` (or `chmod +x fetchy`)
- Copy it to `/usr/local/bin/` (With `ln` if you maintain the repo, or `cp` if you delete it)
- Done! You should now be able to cast `git prunify` as a git command

As a system-wide script:

- Clone the repo
- [Optional] Rename `git-prunify` to just `prunify` to avoid confusion with `git` commands and autocomplete
- Make it executable with `chmod +x git-prunify` (or `chmod +x prunify`)
- Either create a link with `ln` or copy with `cp`: `prunify.sh /usr/local/bin/`
- Add an alias to `.bashrc`: `echo -e '\nalias prunify="prunify"' >> ~/.bashrc`

## Usage

- It has an optional argument `-b` to set a branch to check out to before running the script
- Also, the `-p` parameter can be specified to **print** instead of **delete** each branch
- Another optional argument is `-D`, to force delete branches

Just run it inside a git folder - it will perform a `git fetch -p`, and then `git branch -vv`. It regexps through the ones that contain the string `: gone]`, which indicates that they are no longer present in the upstream, and remove them.
The script won't run if started from a folder that is not a git repository, or from inside the `.git` folder

You can specify a branch to checkout to first via the `-b` argument (E.g: `-b integration`, defaults to `master`), to avoid the error of attempting & failing to delete the branch you are standing on if it was been deleted from the upstream. If you deleted master... well. :boom:

## The loader function

Was basically copied from this [video](https://www.youtube.com/watch?v=93i8txD0H3Q")

## The 'create a custom git command' option

Taken from [here](http://thediscoblog.com/blog/2014/03/29/custom-git-commands-in-3-steps/)
