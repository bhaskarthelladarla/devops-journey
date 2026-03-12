# DevOps Journey

This repository contains my DevOps pratice projects.

## Projects 1: Linux Health Monitoring Script

This script monitors:

- Disk usage
- CPU usage
- memory usage

### Features
- Threshold alert
- Exit codes for automation
- Logging support
- Cron automation

### Usage

Run script:

./scripts/health_checks.sh

Run with custom threshold:

./scripts/health_checks.sh 40

### Automation

Script can run every 5 minutes using cron.

Example:

*/5 * * * * /Dev-Ops/Bhaskar/scripts/health_checks.sh
