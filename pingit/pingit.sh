#!/usr/bin/env bash

# Ping some stuff
# Version 1.5.2
# One IP/hostname per line, blanks are ok and comments are allowed '#' 

if [[ $# -eq 0 ]] || [[ $# -ge 2 ]]
then
  echo "Wrong usage.  Please pass just a filename for input"
  exit 2
fi

infile=$1
if [[ ! -e $infile ]]
then
  echo "ERR: Input file does not exist or readable."
  exit 2
fi

echo "Starting..."
date
upnum=0
downnum=0

for IP in $(cat $infile | sed /^[[:space:]]*$/d | sed /^#.*/d)
do
  ping -c 1 -W 1 "$IP" > /dev/null
  if [[ $? -eq 0 ]]; then
    echo "node $IP is up"
    let upnum++
  else
    echo "node $IP is DOWN"
    let downnum++
  fi
done

echo -e "\n\nAll done."
date
echo "Number of devices UP  : $upnum"
echo "Number of devices DOWN: $downnum"

