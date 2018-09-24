#!/bin/bash
# If passed down, set the branch name
[[ -z $1 ]] && checkout='master' || checkout=$1

# A small animation to display while system fetches
loader=("Fetching   " "Fetching.  " "Fetching.. " "Fetching...")
fetcher(){
  while [ true ]; do
    for i in "${loader[@]}"; do
      echo -ne "\r$i"
      sleep 0.3
    done
  done
}

# Check it's a git repo
ISGIT=$(git rev-parse --is-inside-work-tree 2>/dev/null)
if [[ $ISGIT == "false" ]]; then
  echo "### ERROR: This script should not be run inside .git folder ###"
  return 1
elif [[ $ISGIT != "true" ]]; then
  echo "### Not inside a git repository ###"
  return 1
fi

git checkout $checkout &>/dev/null
fetcher &
pid=$!
# fetch -p
git fetch -p &>/dev/null
kill $pid
wait $pid 2>/dev/null
echo -ne "\r"

# Iterate trhough it. The ones that say ": gone] " should be removed
git branch -vv | while IFS= read -r line ; do
    if [[ $line = *": gone] "*  ]]; then
      IFS=' ' read -r -a array <<< "$line"
      if [[ ${array[0]} == "*" ]]; then 
        branch="${array[1]}"
      else
        branch="${array[0]}"
      fi
      git branch -d $branch
    fi
done
