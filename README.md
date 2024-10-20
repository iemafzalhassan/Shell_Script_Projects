# Project Repository

### Author: Md Afzal Hassan Ehsaani  
**Connect:** [iemafzalhassan@gmail.com](mailto:iemafzalhassan@gmail.com)  
**LinkedIn:** [@iemafzalhassan](https://linkedin.com/in/iemafzalhassan)  
**Twitter:** [@iemafzalhassan](https://twitter.com/iemafzalhassan)

---

## Overview

Welcome to my project collection repository! Here, you'll find a variety of Bash scripts designed to automate and simplify common tasks such as password generation, network checks, backups, and more.

Each script is crafted with clarity and ease of use in mind, aiming to solve practical problems efficiently. Below is a quick overview of each project.

---

## Projects

### 1. Password Generator
**Description:**  
A simple script to generate random, secure passwords of any desired length. The script uses OpenSSL to create a base64-encoded password and allows customization of password length for flexibility.

**Key Features:**  
- Customizable password length  
- Strong encryption-based password generation  
- Single command execution

### 2. Disk Usage Monitor
**Description:**  
Monitors the disk usage on your system and alerts you when the usage exceeds a defined threshold. This is useful for keeping your system healthy and avoiding overfilled partitions.

**Key Features:**  
- Set threshold for disk usage  
- Alerts when the threshold is exceeded  
- Detailed log entries for monitoring usage

### 3. Network Connectivity Checker
**Description:**  
A lightweight script that checks the reachability of a host (default: `google.com`). This is useful for quick network diagnostics or monitoring uptime.

**Key Features:**  
- Pings a specified host to check connectivity  
- Outputs the status with timestamp  
- Logs results for future reference

### 4. Rotational Backup Script
**Description:**  
Automates the process of creating compressed backups of directories and manages backup retention by keeping only the latest 7 backups. Useful for ensuring data safety with minimal manual effort.

**Key Features:**  
- Creates compressed zip backups  
- Automatically deletes the oldest backups if more than 7 exist  
- Ensures continuous backup availability without consuming excessive space

### 5. Service Installation & Monitoring
**Description:**  
A script designed to install services on various Linux distributions (Debian/Ubuntu, RHEL/CentOS) and log the installation process. It also monitors the status of essential services.

**Key Features:**  
- Detects OS type and installs the correct version of the service  
- Logs service installation details  
- Monitors service status post-installation

---

## How to Use

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/iemafzalhassan/Shell_Script_Projects.git
   ```

2. **Navigate to the Project Directory:**
   ```bash
   cd Shell_Script_Projects
   ```

3. **Run Any Script:**
   Each project comes with its own bash script. Simply run the desired script using:
   ```bash
   ./script-name.sh
   ```

---

## License

This repository is licensed under the MIT License. Feel free to use and modify the scripts to suit your needs.

---

### Future Projects

More scripts will be added soon, so stay tuned for updates! Feel free to reach out if you have suggestions or want to contribute.
