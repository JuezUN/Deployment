#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Create backend user if does not exist
id -u backend &>/dev/null || useradd backend

usermod -aG backend $(whoami)

cp backend/backend.sh /usr/local/bin
chown backend:backend /usr/local/bin/backend.sh

cp backend/backend.service /etc/systemd/system
chmod 664 /etc/systemd/system/backend.service

mkdir -p /var/backend/
chown -R backend:backend /var/backend/

systemctl daemon-reload
systemctl enable backend.service
