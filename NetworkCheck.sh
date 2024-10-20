#!/bin/bash

# Function to display a professional ASCII logo and tool information
display_logo() {
    cat << "EOF"
 .                                                                                                                                                                   .
 |                                                                                                                                                                   |
 | .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' |
 |                                                                                                                                                                   |
 |                                                                                                                                                                   |
 `                                                                                                                                                                   `
                     __    _         .                         \            ___  _                    \    
                     |\   |    ___  _/_   ,  _  /   __.  .___  |   ,      .'   \ /        ___    ___  |   ,
                     | \  |  .'   `  |    |  |  | .'   \ /   \ |  /       |      |,---. .'   ` .'   ` |  / 
                     |  \ |  |----'  |    `  ^  ' |    | |   ' |-<        |      |'   ` |----' |      |-<  
                     |   \|  `.___,  \__/  \/ \/   `._.' /     /  \_       `.__, /    | `.___,  `._.' /  \_
                                                                                                           
 .                                                                                                                                                                   .
 |                                                                                                                                                                   |
 | .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' .---' |
 |                                                                                                                                                                   |
 |                                                                                                                                                                   |
 `                                                                                                                                                                   `
EOF

    echo "-------------------------------------------------------"
    echo "|     N E T W O R K   C H E C K   T O O L             |"
    echo "|     A simple tool to check if a host is reachable     |"
    echo "-------------------------------------------------------"
    echo "|   Author: Md Afzal Hassan Ehsaani                     |"
    echo "|   LinkedIn: @iemafzalhassan                           |"
    echo "|   Twitter: @iemafzalhassan                            |"
    echo "-------------------------------------------------------"
    echo "|********************************************************|"
    echo ""
}

# Function to check network connectivity by pinging a host
check_network() {
    HOST="google.com"  # Define the host to ping
    OUTPUT_FILE="/home/ubuntu/output.txt"  # Define the output file for logs

    # Check if the host is reachable by sending one ping packet
    if ping -c 1 $HOST &> /dev/null
    then
        echo "$(date): $HOST is reachable" | tee -a $OUTPUT_FILE
    else
        echo "$(date): $HOST is not reachable" | tee -a $OUTPUT_FILE
    fi
}

# Main script execution
clear  # Clear the terminal for clean output

display_logo  # Display logo and author information

check_network  # Perform network check and log results

