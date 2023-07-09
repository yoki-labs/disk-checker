#!/bin/bash

THRESHOLD=15 # Minimum disk capacity threshold in percentage



# Function to check disk capacity
check_disk_capacity() {
  disk_capacity=$(df -h --output=pcent / | awk 'NR==2 {print $1}')
  disk_capacity=${disk_capacity%?} # Remove the '%' sign

  if ((disk_capacity < THRESHOLD)); then
    message="Warning: Disk usage is ABOVE ${disk_capacity}% <@${GUILDED_DISK_ROLE}>"
    echo $message
    curl -H "Content-Type: application/json" -d "{\"content\":\"$message\"}" "$GUILDED_DISK_URL"
  else
    message="Disk usage is at ${disk_capacity}%"
    echo $message
    curl -H "Content-Type: application/json" -d "{\"content\":\"$message\"}" "$GUILDED_DISK_URL"
  fi
}

check_disk_capacity