#!/bin/bash

# List all containers w/ services/ports they're listening on
# Allows you to run 'netstat' in all running containers w/o requiring netstat package installed inside
## Requires sudo


CONTAINERS=$(docker ps --format "{{.Names}}")

PID=$(docker inspect -f '{{.State.Pid}}' $(docker ps -q))

declare -a array=$CONTAINERS
arraylength=${#array[@]}

sudo echo 'Running script with sudo!'

for name in $CONTAINERS; do
    echo '##########################################################'
    PID=$(docker inspect -f '{{.State.Pid}}' $name)
    echo "$name has PID $PID"
    sudo nsenter -t $PID -n netstat -pln | grep -v dockerd
    echo
    echo '##########################################################'
    echo
done
