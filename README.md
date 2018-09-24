# Fetch Me Clean!

A small bash script for cleaning your local repository of orphaned branches

Clone it, chmod it, run it.

## Usage

Just run it inside a git folder - it will perform a `git fetch -p`, and then `git branch -vv`. It greps through the ones that contain the string `: gone] `, which indicates that they are no longer present in the upstream, and removes them.

## The Safety Check System
 
The script won't run if started from a folder that is not a repository, or from inside the `.git` folder

You can specify a branch to checkout to first via the first argument (E.g: `. fetchmeclean integration`, defaults to `master`), to avoid the error of attempting & failing to delete the branch you are standing in if it was been deleted from the upstream. If you deleted master... well. :boom:

## The loader function

Was basically copiedo from this [video](https://www.youtube.com/watch?v=93i8txD0H3Q")