#!/bin/bash

# Installs the backend service as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Installing the backend service"

# Create backend user if does not exist
id -u backend > /dev/null 2>&1
if [ $? -ne 0 ]
then
    useradd backend
fi

usermod -aG backend $(whoami)

# Sets the IP under `backendhost` in the list of hosts
echo -e "$(hostname -I | awk 'NR==1{print $1}')   backendhost\n" | sudo tee -a /etc/hosts

cp "$DEPLOYMENT_HOME/backend/backend.sh" /usr/local/bin
chown backend:backend /usr/local/bin/backend.sh
chmod +x /usr/local/bin/backend.sh

cp "$DEPLOYMENT_HOME/backend/backend.service" /etc/systemd/system
chmod 664 /etc/systemd/system/backend.service

mkdir -p /var/backend/
chown -R backend:backend /var/backend/

systemctl daemon-reload
systemctl enable backend.service
systemctl start backend.service

sudo firewall-cmd --permanent --add-port=2001/tcp
sudo firewall-cmd --reload
