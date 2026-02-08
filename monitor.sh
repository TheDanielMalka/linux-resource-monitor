#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
USAGE=$(df -h | grep "C:" | awk '{print $6}' | tr -d '%')
LOG_FILE="system_monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")


# For native Linux systems, use: CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}')
# Current implementation uses /proc/loadavg (works in Git Bash but shows 0.00)
CPU_LOAD=$(awk '{print $1 ", " $2 ", " $3}' /proc/loadavg)


# For native Linux systems, use: ps aux --sort=-%mem | head -n 4
# Current implementation uses tasklist (Windows command via Git Bash)
TOP_PROCESSES=$(MSYS_NO_PATHCONV=1 tasklist /nh | sort -rk 5 | head -n 3)

if ! touch "$LOG_FILE" 2>/dev/null; then
    echo -e "${RED}ERROR: Cannot write to log file: $LOG_FILE${NC}"
    exit 1
fi

{
    echo "CPU Load Average: $CPU_LOAD"
    echo "---------------------------------------"
    echo "Report generated at: $TIMESTAMP"
    echo "Memory Info:"
    grep -E "MemTotal|MemFree" /proc/meminfo
    echo "The disk usage is: $USAGE percent"
    echo "Top 3 Memory-Hungry Processes:"
    echo "$TOP_PROCESSES"
} >> "$LOG_FILE"

if [ "$USAGE" -gt 85 ]; then
    echo -e "${RED}WARNING: High disk usage detected: $USAGE%${NC}"
    echo "WARNING: High disk usage detected: $USAGE%" >> "$LOG_FILE"
else
    echo -e "${BLUE}Status: Disk usage is normal ($USAGE%).${NC}"
    echo "Status: Disk usage is normal ($USAGE%)." >> "$LOG_FILE"
fi
