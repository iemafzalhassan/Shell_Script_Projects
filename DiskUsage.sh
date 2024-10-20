#!/bin/bash


# Author: Md Afzal Hassan Ehsaani

# Function to display a disk usage-themed banner with ASCII art

show_banner() {
    clear  # Clear the terminal screen for a clean output
    echo "******************************************"
    echo "|        ██╗   ██╗███████╗███████╗       |"
    echo "|        ██║   ██║██╔════╝██╔════╝       |"
    echo "|        ██║   ██║█████╗  █████╗         |"
    echo "|        ██║   ██║██╔══╝  ██╔══╝         |"
    echo "|        ╚██████╔╝███████╗███████╗       |"
    echo "|         ╚═════╝ ╚══════╝╚══════╝       |"
    echo "******************************************"
    echo "|    D I S K   U S A G E   M O N I T O R  |"
    echo "******************************************"
    echo "|  Author: Md Afzal Hassan Ehsaani        |"
    echo "|----------------------------------------|"
    echo "|  Checking disk usage and alerting      |"
    echo "|  when usage exceeds the set threshold  |"
    echo "******************************************"
}

# Display the banner

show_banner

sleep 3  # Pause for 3 seconds for effect


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
        echo ""
        echo "******************************************"
        echo "|        ALERT: High Disk Usage!         |"
        echo "|    Partition: $partition               |"
        echo "|    Usage: ${usage}%                    |"
        echo "|    Take action: Scale or clean space   |"
        echo "******************************************"
        echo ""
        sleep 2  # Pause for readability

        log_message "Warning: Disk usage on $partition is at ${usage}%"
    else
        echo "Disk usage on $partition  is healthy at: ${usage}%"
    fi
done

# Optionally: Send a summary report of the disk usage

log_message "Disk usage check completed."

