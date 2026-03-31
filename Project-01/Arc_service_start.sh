#!/bin/bash
# variables
TODAY=$(date +%d)

echo "Finding the First Backup directory for today: $TODAY"
# Find the first backup directory for today
BACKUP_DIR=$(ls -d /root/CRQ/collected_data_* | grep "/collected_data_$TODAY" | head -n 1)
if [ -z "$BACKUP_DIR" ]; then
    echo "No backup directory found for today: $TODAY"
    exit 1
fi
echo "Backup directory found: $BACKUP_DIR"
# Check if the chkconfig_list.out file exists in the backup directory
CHKCONFIG_FILE="$BACKUP_DIR/chkconfig_list.out"
if [ ! -f "$CHKCONFIG_FILE" ]; then
    echo "chkconfig_list.out file not found in the backup directory: $BACKUP_DIR"
    exit 1
fi
echo "chkconfig_list.out file found: $CHKCONFIG_FILE"

# check if any services are found in the backup file
if ! grep -q '^arc' "$CHKCONFIG_FILE"; then
    echo "No ARC related services found in the backup file: $CHKCONFIG_FILE"
    exit 0
fi
echo "ARC related services found in the backup file: $CHKCONFIG_FILE"

# Read the chkconfig_list.out file.
while IFS= read -r line; do
# Filter only ARC services
if [[ "$line" =~ ^arc ]]; then
Service_Name=$(echo "$line" | awk '{print $1}')

# Extract "ON" or "OFF" status for runlevels 2,3, 4, and 5 ( convert to 2345 format)
Service_levels=$(echo "$line" | grep -o '[0-6]:on' | cut -d: -f1 | tr -d '\n')

if [[ -z "$Service_levels" ]]; then
echo "skipping $Service_Name as it is not set to ON in any runlevel"
else
echo "Starting service: $Service_Name with runlevels: $Service_levels"
# Start the service using chkconfig
chkconfig --level $Service_levels $Service_Name on > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo "Service $Service_Name started successfully."
else
echo "Failed to start service $Service_Name."
fi
fi
fi
done < "$CHKCONFIG_FILE"
