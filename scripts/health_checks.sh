#!/bin/bash
# This script performs health checks on a RHEL system.
# If no argument, default 80%
THRESHOLD=${1:-80}
LOGFILE="/Dev-Ops/Bhaskar/logs/health_checks.log"
# Function to log messages

echo "========Health check started at $(date)===========" >> "$LOGFILE"
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}
# check DISK USAGE
Disk_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: $Disk_USAGE%" >> "$LOGFILE"

# check Memory USAGE
Memory_USAGE=$(free -m | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100.0}')
echo "Memory Usage: $Memory_USAGE%" >> "$LOGFILE"

# Check CPU USAGE
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*} # Convert to integer
echo "CPU Usage: $CPU_USAGE%" >> "$LOGFILE"

STATUS=0

if [ "$Disk_USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is above threshold!" >> "$LOGFILE"
    STATUS=1
fi

if [ "$Memory_USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: Memory usage is above threshold!" >> "$LOGFILE"
    STATUS=1
fi

if [ "$CPU_INT" -gt "$THRESHOLD" ]; then
    echo "WARNING: CPU usage is above threshold!" >> "$LOGFILE"
    STATUS=1
fi
echo "Health check completed with status: $STATUS" >> "$LOGFILE"
echo "========Health check ended at $(date)===========" >> "$LOGFILE"
exit $STATUS
