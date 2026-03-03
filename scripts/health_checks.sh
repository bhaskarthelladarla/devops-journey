#!/bin/bash
LOG_FILE="/var/log/health_checks.log"
# Function to log messages.
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}
log_message "=============Starting system health checks================="
# Disk usage check
log_message "Starting Disk Usage check..."
df -h | tee -a "$LOG_FILE"
# Top commands check
log_message "Starting TOP commands check..."
top -b -n 1 | head -n 20 | tee -a "$LOG_FILE"
# Memory usage check
log_message "Starting Memory Usage check..."
free -h | tee -a "$LOG_FILE"
# CPU usage check
log_message "Starting CPU Usage check..."
mpstat | tee -a "$LOG_FILE"
# Network connectivity check
log_message "Starting Network Connectivity check..."
ping -c 4 google.com | tee -a "$LOG_FILE"
# All systemd service check
log_message "Starting systemd service check..."
systemctl list-units --type=service --state=running | tee -a "$LOG_FILE"
log_message "=============Completed system health checks================="
