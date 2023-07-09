#!/bin/bash

THRESHOLD=15 # Minimum disk capacity threshold in percentage

# Function to check disk capacity
check_disk_capacity() {
  disk_capacity=$(df -h --output=pcent / | awk 'NR==2 {print $1}')
  disk_capacity=${disk_capacity%?} # Remove the '%' sign

  if ((disk_capacity < THRESHOLD)); then
    echo "Warning: Disk capacity is below ${THRESHOLD}%"
    message="Warning: Disk capacity is below ${THRESHOLD}% <@${GUILDED_DISK_ROLE}>"
    curl -H "Content-Type: application/json" -d "{\"content\":\"$message\"}" "$GUILDED_DISK_URL"
  else
    echo "Disk capacity is at ${disk_capacity}%"
    message="Disk capacity is below ${THRESHOLD}%"
    curl -H "Content-Type: application/json" -d "{\"content\":\"$message\"}" "$GUILDED_DISK_URL"
  fi
}

check_disk_capacity