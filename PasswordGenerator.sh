#!/bin/bash

#=========================================================
#   *** Author:       MD. Afzal Hassan Ehsani  ***
#   *** Connect Here: iemafzalhassan@gmail.com ***
#   *** Date:         Friday-24-October-2024   ***
#=========================================================



echo " Password Generator "

sleep 3

echo "Enter your password length"

read PASS_LENGTH

for i in $(seq 1 );
do
    openssl rand -base64 48 | cut -c1-$PASS_LENGTH
done

