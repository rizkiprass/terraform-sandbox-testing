#!/bin/bash

# Update the system's package lists
apt update

# Install OpenVPN Access Server dependencies
apt -y install wget

# Download OpenVPN Access Server
wget https://swupdate.openvpn.net/as/openvpn-as-2.8.8-Ubuntu20.amd_64.deb

# Install OpenVPN Access Server
dpkg -i openvpn-as-2.8.8-Ubuntu20.amd_64.deb

# Start OpenVPN Access Server service
systemctl start openvpnas

# Enable OpenVPN Access Server to start on boot
systemctl enable openvpnas

# Save the initial administrator password
initial_password=$(cat /usr/local/openvpn_as/etc/initial_pwd)
echo "$initial_password" > /home/ubuntu/openvpn_password.txt