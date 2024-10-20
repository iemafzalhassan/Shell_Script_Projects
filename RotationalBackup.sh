#!/bin/bash

# Check if no arguments are provided
if [[ $# -eq 0 ]]; then
  echo "Error: No arguments provided."
  echo "Usage: $0 <source_directory> <destination_directory>"
  echo "Please provide the source and destination directory path as arguments to successfully complete the backup."
  exit 1
fi

# Check if both arguments are provided
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  echo "Please provide both source and destination directory paths."
  exit 1
fi

# Source and destination directories from arguments
SOURCE="$1"
DESTINATION="$2"

# Current timestamp in 12-hour format (e.g., 2024-10-07_11-45-33_PM)
DATE=$(date +%Y-%m-%d_%I-%M-%S_%p)

# Naming convention for backup zip file
BACKUP_NAME="Backup_$DATE.zip"

# Ensure source directory exists
if [[ ! -d "$SOURCE" ]]; then
  echo "Error: Source directory $SOURCE does not exist."
  exit 1
fi

# Ensure destination directory exists
mkdir -p "$DESTINATION"
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to create destination directory $DESTINATION."
  exit 1
fi

# Count the number of existing backups in the destination directory
BACKUP_COUNT=$(ls -1q "$DESTINATION"/Backup_*.zip 2>/dev/null | wc -l)

# If there are 7 or more backups, delete the oldest one
if [[ $BACKUP_COUNT -ge 7 ]]; then
  echo "There are already 7 or more backups. Deleting the oldest one..."
  OLDEST_BACKUP=$(ls -1t "$DESTINATION"/Backup_*.zip | tail -1)  # Get the oldest backup
  rm -f "$OLDEST_BACKUP"
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to delete the oldest backup $OLDEST_BACKUP."
    exit 1
  fi
  echo "Oldest backup $OLDEST_BACKUP deleted successfully."
fi

# Create zip of the source directory
echo "Creating zip archive of $SOURCE..."
zip -r "$DESTINATION/$BACKUP_NAME" "$SOURCE" > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to create zip file $BACKUP_NAME in $DESTINATION."
  exit 1
fi

echo "Backup completed successfully on $DATE. Stored as $DESTINATION/$BACKUP_NAME."

# Ensure the backup count remains at 7
NEW_BACKUP_COUNT=$(ls -1q "$DESTINATION"/Backup_*.zip | wc -l)
if [[ $NEW_BACKUP_COUNT -gt 7 ]]; then
  echo "Backup count exceeded 7. Deleting oldest backups..."
  while [[ $(ls -1q "$DESTINATION"/Backup_*.zip | wc -l) -gt 7 ]]; do
    OLDEST_BACKUP=$(ls -1t "$DESTINATION"/Backup_*.zip | tail -1)
    rm -f "$OLDEST_BACKUP"
    if [[ $? -ne 0 ]]; then
      echo "Error: Failed to delete old backup $OLDEST_BACKUP."
      exit 1
    fi
    echo "Deleted old backup $OLDEST_BACKUP."
  done
fi

echo "Backup rotation completed."

