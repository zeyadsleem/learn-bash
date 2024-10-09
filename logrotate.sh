#!/bin/bash

LOG_DIR="/var/log/myapp"
# Variables
MAX_LOG_SIZE=5000000 # 5 MB
MAX_LOG_AGE=30       # 30 Days

# Function to rotate logs
rotate_logs() {
	for log_file in "$LOG_DIR"/*.log; do
		if [ $(stat -c%s "$log_file") -gt $MAX_LOG_SIZE ]; then
			mv "$log_file" "$log_file.$(date + '%Y%m%d')"
			gzip "$log_file.$(date + '%Y%m%d')"
			echo "Log rotated: $log_file"
		fi
	done
}

# Function clean up old logs
clean_old_logs() {
	find "$LOG_DIR" -name "*gz" -mtime +$MAX_LOG_AGE -exec rm {} \;
	echo "Old logs cleaned up"
}

# Run the functions
rotate_logs
clean_old_logs
