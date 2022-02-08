#!/bin/bash

#
# A bash script to check service (from service.txt) and start this one if is not started
#
# By default:
# This script will try to start service 3 times (attempts) with 3 seconds interval (interval)
#

service=$(cat service.txt)
interval=3
attempts=2

for serv in $service; do
    echo "------------------------------------"
    i=0
    while [ $i -le $attempts ]; do
        systemctl is-active --quiet $serv 
        if [ $? -eq 0 ]; then
        echo "$serv is running"
        break
        else
        echo "$serv is NOT running, try to start"
        systemctl start $serv
            if [ $? -eq 0 ]; then
                echo "$serv started"    
            else
                echo "$serv not started"
            fi
        sleep $interval
        fi
    ((i++))
    done
done
echo "------------------------------------"
