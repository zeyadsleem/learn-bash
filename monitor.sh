#!/bin/bash

# Variables

CPU_THRESHOLD=10
MEMORY_THRESHOLD=10
DISK_THRESHOLD=10

# Function to check CPU usage
check_cpu_usage() {
	cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
	if ($(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l)); then
		echo "CPU usage is $cpu_usage, which is above the threshold of $CPU_THRESHOLD"
	else
		echo "CPU usage is $cpu_usage, which is below the threshold of $CPU_THRESHOLD"
	fi
}

# Function to check Memory usage
check_memory_usage() {
	memory_usage=$(free -m | grep "Mem:" | awk '{print $3/$2 * 100.0}')
	if (($(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l))); then
		echo "Memory usage is $memory_usage, which is above the threshold of $MEMORY_THRESHOLD"
	else
		echo "Memory usage is $memory_usage, which is below the threshold of $MEMORY_THRESHOLD"
	fi
}

# Function to check Disk usage
check_disk_usage() {
	disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
	if [ "$disk_usage" -gt $DISK_THRESHOLD ]; then
		echo "Disk usage is $disk_usage, which is above the threshold of $DISK_THRESHOLD"
	else
		echo "Disk usage is $disk_usage, which is below the threshold of $DISK_THRESHOLD"
	fi
}

# Run the checks
check_cpu_usage
check_memory_usage
check_disk_usage
