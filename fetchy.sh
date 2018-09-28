#!/bin/bash
checkout="master"
delete="-d"
print=''

while getopts ":b:Dp" opt; do
  case ${opt} in
    b ) checkout=$OPTARG ;;
    D ) delete="-D" ;;
    p ) print="yes" ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2 ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2 ;;
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