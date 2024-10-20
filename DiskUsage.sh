#!/bin/bash

# Set the threshold for disk usage

THRESHOLD=80

# Log file to store output

LOG_FILE="/var/log/disk_usage_monitor.log"

# Function to log messages with a timestamp

log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# Check disk usage and print a warning if usage is above the threshold

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read -r output; do
    usage=$(echo "$output" | awk '{ print $1}' | cut -d'%' -f1)
    partition=$(echo "$output" | awk '{ print $2 }')

    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo "Warning: Disk usage on $partition is at ${usage}%"
        log_message "Warning: Disk usage on $partition is at ${usage}%"
    else
        echo "Disk usage on $partition is under control: ${usage}%"
    fi
done

# Optionally: Send a summary report of the disk usage

log_message "Disk usage check completed."
