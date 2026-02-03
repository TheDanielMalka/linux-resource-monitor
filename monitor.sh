#!/bin/bash

USAGE=$(df -h | grep "C:" | awk '{print $6}' | tr -d '%')
LOG_FILE="system_monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "------------------------------------------" >> $LOG_FILE
echo "Report generated at: $TIMESTAMP" >> $LOG_FILE

echo "Memory Info:" >> $LOG_FILE
cat /proc/meminfo | grep -E "MemTotal|MemFree" >> $LOG_FILE

echo "The disk usage is: $USAGE percent" >> $LOG_FILE

if [ $USAGE -gt 85 ]; then
    echo "WARNING: High disk usage detected: $USAGE%" >> $LOG_FILE
else
    echo "Status: Disk usage is normal." >> $LOG_FILE
fi
