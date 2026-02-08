#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

LOG_DIR="/var/log/monitor"
LOG_FILE="$LOG_DIR/system_monitor.log"
SCRIPT_NAME="system_monitor.sh"

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}ERROR: Please run this script with sudo${NC}"
    exit 1
fi

check_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo -e "${GREEN}Detected OS: $NAME $VERSION${NC}"
    else
        echo -e "${RED}WARNING: Could not detect OS${NC}"
    fi
}

setup_log_dir() {
    if [ -d "$LOG_DIR" ]; then
        echo -e "${GREEN}Log directory already exists: $LOG_DIR${NC}"
    else
        mkdir -p "$LOG_DIR"
        echo -e "${GREEN}Created log directory: $LOG_DIR${NC}"
    fi
    chmod 755 "$LOG_DIR"
    touch "$LOG_FILE"
    chmod 644 "$LOG_FILE"
}

echo "=== Starting Setup ==="
check_os
setup_log_dir
echo "=== Setup Complete ==="
