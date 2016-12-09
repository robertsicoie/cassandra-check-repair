#!/bin/bash

if [ $# -ne 3 ]
then
  echo -e "\nUsage:\n$0 <hostname> <username> <password>"
  exit 1
fi

TARGET_HOST=$1
USER=$2
PASS=$3

for hostname in $( nodetool -h $TARGET_HOST -u $USER -pw $PASS status | sed -e '1,5d' | awk '/[U]N/ {print $2}' )
do
  echo Checking $hostname for ongoing repairs
  nodetool -h $hostname -u $USER -pw $PASS tpstats | grep Repair#
  response=$?
  if [ $response -eq 0 ]
  then
    repair_ongoing=true
    echo "Ongoing repair on $hostname"
  fi
done

if ! [ $repair_ongoing ]
then
  echo "Taking a snapshot."
  nodetool -h $TARGET_HOST -u $USER -pw $PASS snapshot
  echo "Starting repair on $TARGET_HOST"
  nodetool -h $TARGET_HOST -u $USER -pw $PASS repair
fi
