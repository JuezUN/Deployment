#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cp docker_agent.sh /usr/local/bin
cp mcq_agent.sh /usr/local/bin

chown agent:agent /usr/local/bin/docker_agent.sh
chown agent:agent /usr/local/bin/mcq_agent.sh

cp units/docker_agent.service /etc/systemd/system
cp units/mcq_agent.service /etc/systemd/system

chmod 664 /etc/systemd/system/docker_agent.service
chmod 664 /etc/systemd/system/mcq_agent.service

cp units/inginious_agents.conf /etc/sysconfig

mkdir -p /var/agent/
chown -R agent:agent /var/agent/

systemctl daemon-reload
systemctl enable docker_agent.service
systemctl enable mcq_agent.service
