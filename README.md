# Fetchy - Trim your git tree from broken branches!

A small bash script for cleaning your local repository of orphaned branches :fallen_leaf:


Clone it, chmod it, run it.

## Usage

- It has an optional argument for a branch to check out to, the why explained below
- Another optional argument is `-D`, to force delete branches
- [optional] create a symbolic link with `ln fetchy.sh /usr/local/bin/`
- [optional] add an alias `echo 'alias fetchy="fetchy"' >> ~/.bashrc`

Just run it inside a git folder - it will perform a `git fetch -p`, and then `git branch -vv`. It greps through the ones that contain the string `: gone] `, which indicates that they are no longer present in the upstream, and removes them.
The script won't run if started from a folder that is not a git repository, or from inside the `.git` folder

You can specify a branch to checkout to first via the first argument (E.g: `. fetchmeclean integration`, defaults to `master`), to avoid the error of attempting & failing to delete the branch you are standing in if it was been deleted from the upstream. If you deleted master... well. :boom:

## The loader function

Was basically copied from this [video](https://www.youtube.com/watch?v=93i8txD0H3Q")