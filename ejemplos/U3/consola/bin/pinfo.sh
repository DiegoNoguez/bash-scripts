#! /bin/bash

PIDS=$(pgrep $1)

for pid in $PIDS; do
    echo "________________"
    echo "Proceso No. $pid"
    echo "________________"
    pmap $pid | awk 'END {print $2/1024, "MB" }'
    echo " "
done 