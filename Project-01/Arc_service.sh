#!/bin/bash
# variables
Services=("test" "service2" "service3") # Replace with actual service names
if [ "$1" == "stop" ]; then
    for SERVICE in "${Services[@]}"; do
        if chkconfig --list | grep $SERVICE &>/dev/null; then
            echo "Stopping $SERVICE using chkconfig..."
            chkconfig $SERVICE off
        else
            echo "Service $SERVICE not found in runlevels."
        fi
    done
elif [ "$1" == "start" ]; then
    for SERVICE in "${Services[@]}"; do
        if chkconfig --list | grep $SERVICE &>/dev/null; then
            echo "Starting $SERVICE using chkconfig..."
            chkconfig $SERVICE on
        else
            echo "Service $SERVICE not found in runlevels."
        fi
    done
else
    echo "Invalid argument. Use 'stop' or 'start'."
    exit 1
fi
