#!/bin/bash

LOG_FILE="system_monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "------------------------------------------" >> $LOG_FILE
echo "Report generated at: $TIMESTAMP" >> $LOG_FILE

echo "Memory Info:" >> $LOG_FILE
cat /proc/meminfo | grep -E "MemTotal|MemFree" >> $LOG_FILE

echo "Disk Usage:" >> $LOG_FILE
df -h | grep "C:" >> $LOG_FILE
