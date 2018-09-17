#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cp docker_agent.sh /usr/local/bin
cp mcq_agent.sh /usr/local/bin

cp units/docker_agent.service /etc/systemd/system
cp units/mcq_agent.service /etc/systemd/system

chmod 664 /etc/systemd/system/docker_agent.service
chmod 664 /etc/systemd/system/mcq_agent.service

systemctl daemon-reload
systemctl enable docker_agent.service
systemctl enable mcq_agent.service
