#!/bin/bash
# variables
DATE=$(date +%Y-%m-%d)
OUTPUT_FILE="/root/CRQ/services_runlevels.logs"
SERVICES=("test" "service2" "service3") # Replace with actual service
echo "==========$DATE - Checking and managing services at boot level ==========" >> $OUTPUT_FILE
for SERVICE in "${SERVICES[@]}"; do
    if chkconfig --list $SERVICE &>/dev/null; then
        SERVICE_STATUS=$(chkconfig --list $SERVICE | grep -E "3:on|4:on|5:on")
        if [ -n "$SERVICE_STATUS" ]; then
            echo "Service $SERVICE is ON in runlevels 3, 4, or 5. Stopping $SERVICE..." >> $OUTPUT_FILE
            chkconfig $SERVICE off >> $OUTPUT_FILE 2>&1
        else
            echo "Service $SERVICE is OFF in runlevels 3, 4, and 5. Starting $SERVICE..." >> $OUTPUT_FILE
            chkconfig $SERVICE on >> $OUTPUT_FILE 2>&1
        fi
    fi
done

