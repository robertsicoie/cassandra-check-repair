#!/bin/bash

for target in $( nodetool -h localhost status | sed -e '1,5d' | awk '/[U]N/ {print $2}' )
do

    echo "=== Target $target ==="

    for hostname in $( nodetool -h $target status | sed -e '1,5d' | awk '/[U]N/ {print $2}' )
    do
      echo Checking $hostname for ongoing repairs | sed 's/^/    /g'
      nodetool -h $hostname tpstats | grep -q Repair#
      response=$?
      if [ $response -eq 0 ]
      then
        repair_ongoing=true
        echo "Ongoing repair on $hostname" | sed 's/^/    /g'
      fi
    done

    echo

    if ! [ $repair_ongoing ]
    then
      echo "Taking a snapshot." | sed 's/^/    /g'
      nodetool -h $target snapshot | sed 's/^/        /g'
      echo "Starting repair on $TARGET_HOST" | sed 's/^/    /g'
      nodetool -h $target repair -pr | sed 's/^/        /g'
    fi
    echo

done
