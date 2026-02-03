#!/bin/bash

echo "--- System Monitoring Report ---"
date
echo "--------------------------------"
echo "Memory Info:"
cat /proc/meminfo | grep -E "MemTotal|MemFree"

echo ""
echo "Disk Usage:"
df -h | grep -E "C:|D:"
