#!/bin/bash
# variables
THRESHOLD=80
LOG_FILE="/Dev-Ops/Bhaskar/health_checks.log"
# Function to log messages.
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}
log_message "Starting disk usage check..."
# Check disk usage and alert if it exceeds the threshold.
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    log_message "Disk usage is at ${USAGE}%, which exceeds the threshold of ${THRESHOLD}%."
    exit 1
else
    log_message "Disk usage is at ${USAGE}%, which is within the acceptable range."
    exit 0
fi
