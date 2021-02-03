#!/bin/bash

# Run script to run a new grader server for the backend service

sudo bash "$DEPLOYMENT_HOME/deployment_scripts/install_nfs.sh"

# Read the agent server IP to allow sharing the folder
read -p "Enter agent server IP: " server_ip

echo -e "/var/www/INGInious/tasks $server_ip(rw,sync,no_root_squash)\n" | sudo tee -a /etc/exports

sudo exportfs -a

sudo systemctl restart nfs-server

firewall-cmd --permanent --add-service mountd
firewall-cmd --permanent --add-service rpc-bind
firewall-cmd --permanent --add-service nfs
firewall-cmd --reload