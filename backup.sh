#!/bin/bash

# Variables

SOURCE_DIR="/root/backup"
LOG_FILE="backup.log"
REMOTE_HOST="root@192.168.64.4"
REMOTE_DIR="/root/"

# Function to preform the backup

perform_backup() {
	rsync -avz "$SOURCE_DIR" "$REMOTE_HOST":"$REMOTE_DIR" >"$LOG_FILE" 2>&1
	if [ $? -eq 0 ]; then
		echo "Backup successful: $(date)" >>"$LOG_FILE"
	else
		echo "Backup failed: $(date)" >>"$LOG_FILE"
	fi
}

# Run the backup

perform_backup
