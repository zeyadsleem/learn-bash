#!/bin/bash

# Variables
INTERFACE="enp7s0"
STATIC_IP="192.168.1.100"
CIDR=24
GATEWAY="192.168.1.1"
DNS="8.8.8.8"

# Function to static IP
configure_static_ip() {
	echo "Configuring static IP..."
	sudo nmcli con add type ethernet autoconnect yes con-name $INTERFACE ifname $INTERFACE
	sudo nmcli con mod "$INTERFACE" ipv4.addresses $STATIC_IP/$CIDR
	sudo nmcli con mod "$INTERFACE" ipv4.gateway $GATEWAY
	sudo nmcli con mod "$INTERFACE" ipv4.dns $DNS
	sudo nmcli con mod "$INTERFACE" ipv4.method manual
	echo "Static IP configured successfully."
}

# Function to restart the network service
restart_network_service() {
	echo "Restarting network service..."
	sudo nmcli con up "$INTERFACE"
	echo "Network service restarted successfully."
}

# Function to display current network configuration
show_network_config() {
	echo "Displaying current network configuration..."
	ip addr show "$INTERFACE"
	echo "Current network configuration displayed successfully."
}

# Function to automate the whole network configuration
automate_network_config() {
	configure_static_ip
	restart_network_service
	show_network_config
}

# Execute the automation function
automate_network_config
