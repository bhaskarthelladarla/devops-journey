#!/bin/bash
# variables
TIME=`date +%d_%m:%H_%M`

# Backup the existing chkconfig services list to a file with timestamp
chkconfig --list | grep -i '^arc' > /tmp/chkconfig_services_backup_$TIME.txt

# Get all services details which are related to ARC.
Services=$(chkconfig --list | awk '{print $1}' | grep -i '^arc')

# Check if any services are found
if [ -z "$Services" ]; then
    echo "No ARC related services found in runlevels."
    exit 0
fi
echo "ARC related services found"
echo "$Services"
# Loop through each service and stop it using chkconfig
for SERVICE in $Services; do
    if chkconfig --list | grep $SERVICE &>/dev/null; then
        echo "Stopping $SERVICE using chkconfig..."
        chkconfig $SERVICE off
    else
        echo "Service $SERVICE not found in runlevels."
    fi
done
