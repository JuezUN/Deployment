#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cp docker_agent.sh /usr/local/bin
cp mcq_agent.sh /usr/local/bin

cp units/docker_agent.service /etc/systemd/system/multi-user.target.wants
cp units/mcq_agent.service /etc/systemd/system/multi-user.target.wants

systemctl daemon-reload
systemctl enable docker_agent
systemctl enable mcq_agent
