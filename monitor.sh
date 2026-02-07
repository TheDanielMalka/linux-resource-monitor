#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
USAGE=$(df -h | grep "C:" | awk '{print $6}' | tr -d '%')
LOG_FILE="system_monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
CPU_LOAD=$(awk '{print $1 ", " $2 ", " $3}' /proc/loadavg)

{
    echo "CPU Load Average: $CPU_LOAD"
    echo "---------------------------------------"
    echo "Report generated at: $TIMESTAMP"
    echo "Memory Info:"
    grep -E "MemTotal|MemFree" /proc/meminfo
    echo "The disk usage is: $USAGE percent"
} >> "$LOG_FILE"

if [ "$USAGE" -gt 85 ]; then
    echo -e "${RED}WARNING: High disk usage detected: $USAGE%${NC}"
    echo "WARNING: High disk usage detected: $USAGE%" >> "$LOG_FILE"
else
    echo -e "${BLUE}Status: Disk usage is normal ($USAGE%).${NC}"
    echo "Status: Disk usage is normal ($USAGE%)." >> "$LOG_FILE"
fi
