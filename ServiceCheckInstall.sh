 #!/bin/bash
# Author: Md Afzal Hassan Ehsaani

# Function to display a stylish banner design
show_banner() {
    clear  # Clear the terminal screen for a clean output
    echo "******************************************"
    echo "*                                        *"
    echo "*        D E V O P S   S C R I P T       *"
    echo "*                                        *"
    echo "******************************************"
    echo "*    Script by: Md Afzal Hassan Ehsaani   *"
    echo "******************************************"
}

# Display the banner
show_banner
sleep 3  # Pause for 3 seconds for effect

# Log file to store output
LOG_FILE="/var/log/service_monitor.log"

# Function to log messages with a timestamp
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %I:%M:%S %p') - $message" | sudo tee -a "$LOG_FILE"
}

# Function to install the service based on OS type
install_service() {
    case "$1" in
        "debian" | "ubuntu")
            echo "Installing $SERVICE on Debian/Ubuntu..."
            log_message "Installing $SERVICE on Debian/Ubuntu..."
            sudo apt update && sudo apt install -y $SERVICE
            ;;
        "rhel" | "centos" | "fedora")
            echo "Installing $SERVICE on RHEL/CentOS/Fedora..."
            log_message "Installing $SERVICE on RHEL/CentOS/Fedora..."
            sudo yum install -y $SERVICE
            ;;
        "darwin")
            echo "Installing $SERVICE on macOS..."
            log_message "Installing $SERVICE on macOS..."
            brew install $SERVICE
            ;;
        *)
            echo "Unsupported OS."
            log_message "Unsupported OS detected."
            exit 1
            ;;
    esac
}

# Function to manage the service based on the OS type
start_service() {
    case "$1" in
        "debian" | "ubuntu" | "rhel" | "centos" | "fedora")
            echo "Checking $SERVICE service using systemd..."
            log_message "Checking $SERVICE service using systemd..."
            sleep 2
            if sudo systemctl is-active --quiet $SERVICE; then
                echo "$SERVICE is running."
                log_message "$SERVICE is already running."
            else
                echo "$SERVICE is not running. Starting service..."
                log_message "$SERVICE is not running. Attempting to start..."
                sudo systemctl start $SERVICE
                if [[ $? -eq 0 ]]; then
                    echo "$SERVICE has been started successfully."
                    log_message "$SERVICE started successfully."
                else
                    echo "Failed to start $SERVICE."
                    log_message "Failed to start $SERVICE."
                    exit 1
                fi
            fi
            ;;
        "darwin")
            echo "Managing $SERVICE service using launchctl (macOS)..."
            log_message "Managing $SERVICE service using launchctl..."
            sleep 2
            if sudo launchctl list | grep -q $SERVICE; then
                echo "$SERVICE is running on macOS."
                log_message "$SERVICE is already running on macOS."
            else
                echo "$SERVICE is not running. Starting service on macOS..."
                log_message "Starting $SERVICE service on macOS..."
                sudo brew services start $SERVICE
                if [[ $? -eq 0 ]]; then
                    echo "$SERVICE has been started successfully on macOS."
                    log_message "$SERVICE started successfully on macOS."
                else
                    echo "Failed to start $SERVICE on macOS."
                    log_message "Failed to start $SERVICE on macOS."
                    exit 1
                fi
            fi
            ;;
        *)
            echo "Unsupported OS for managing services."
            log_message "Unsupported OS for managing services."
            exit 1
            ;;
    esac
}

# Detect the OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

case "$OS" in
    "linux")
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS_NAME=$ID
        fi
        ;;
    "darwin")
        OS_NAME="darwin"
        ;;
    *)
        echo "Unsupported OS."
        log_message "Unsupported OS detected."
        exit 1
        ;;
esac

# Check if the user has provided the service name as an argument
if [[ -z "$1" ]]; then
    echo "Error: Please provide a service name as an argument."
    echo "Usage: $0 <service_name>"
    exit 1
fi

SERVICE=$1

# Pause for effect
echo "Checking if $SERVICE is installed..."
sleep 3  # Pause for 3 seconds

# Check if the service is installed
if command -v $SERVICE &> /dev/null; then
    echo "$SERVICE is already installed."
    log_message "$SERVICE is already installed."
else
    echo "$SERVICE is not installed. Installing..."
    log_message "$SERVICE is not installed. Attempting to install..."
    install_service "$OS_NAME"
    sleep 2  # Pause for installation process
fi

# Pause for effect
echo "Starting or managing $SERVICE..."
sleep 2  # Pause for effect

# Start or manage the service using the correct daemon system
start_service "$OS_NAME"

# Log the current status of the service
if [[ "$OS_NAME" != "darwin" ]]; then
    sudo systemctl status $SERVICE >> "$LOG_FILE" 2>&1
else
    sudo brew services list | grep $SERVICE >> "$LOG_FILE" 2>&1
fi

echo "All tasks completed."
sleep 2  # Final pause

