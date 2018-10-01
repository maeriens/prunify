#!/bin/bash
checkout="master"
delete="-d"
print=''

usage(){
    echo
    echo " Usage: $0 [options]"
    echo
    echo "   -b [branch]    checkout to [branch] before starting. Defaults to master"
    echo "   -D             force-deletes branches instead of soft-delete"
    echo "   -p             prints the branches instead of deleting them"
}
while getopts ":b:Dhp" opt; do
  case ${opt} in
    b ) checkout=$OPTARG; echo "A" ;;
    D ) delete="-D" ;;
    p ) print="yes" ;;
    : )
      echo " Invalid option: $OPTARG requires an argument"; usage ; exit 1 ;;
    \? )
      echo " Invalid option: $OPTARG"; usage; exit 1 ;;
  esac
done

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

echo "Checking out to $checkout"
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
      if [[ ${print} ]]; then
        echo "Found orphaned branch ${branch}"
      else
        git branch $delete $branch
      fi
    fi
done