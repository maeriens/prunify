# git-prunify - Trim your git tree from broken branches

A small bash script for cleaning your local repository of orphaned branches :fallen_leaf:

Clone it, chmod it, copy it.

## Installation
This will make the script executable with git. You can also add some autocomplete for it.

- Clone the repo
- Make it executable with `chmod +x git-prunify`
  - You can copy it to `/usr/local/bin/`, as this folder is already in the system's PATH variable
  - You can keep it in the cloned folder but you have to add it to the PATH (`echo -e '\n~/Repos/prunify' >> ~/.zshrc`)
- Done! You should now be able to cast `git prunify` as a git command

It seems that on most Linux distros, autocomplete works out of the box. If it does not work, or you are on OSX, with `zsh` you can add `zstyle ':completion:*:*:git:*' user-commands prunify:'Remove outdated branches'` to the end of the `.zshrc` to have it show in the autocomplete section

## Usage

- It has an optional argument `-b` to set a branch to check out to before running the script
- Also, the `-p` parameter can be specified to **print** instead of **delete** each branch
- Another optional argument is `-D`, to force delete branches

Just run it inside a git folder - it will perform a `git fetch -p`, and then `git branch -vv`. It *regexps* through the ones that contain the string `: gone]`, which indicates that they are no longer present in the upstream, and removes them.
The script will not run if started from outside a git repository, or from inside the `.git` folder

You can specify a branch to checkout to first via the `-b` argument *(E.g: `-b integration`)*, to avoid the error of attempting & failing to delete the branch you are standing on if it was removed from the upstream. If you try to delete the current branch... well. :boom:

## The loader function

Was basically copied from this [video](https://www.youtube.com/watch?v=93i8txD0H3Q")

## The 'create a custom git command' option

Originally from [here](http://thediscoblog.com/blog/2014/03/29/custom-git-commands-in-3-steps/)
But that site seems to be old, so refer to [this one](https://gitbetter.substack.com/p/automate-repetitive-tasks-with-custom)