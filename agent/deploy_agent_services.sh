#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "127.0.0.1   backendhost" | sudo tee -a /etc/hosts

# Create agent user and group
sudo useradd agent

echo "Provide a password for the agent user"

sudo passwd agent
sudo usermod -aG agent agent
sudo usermod -aG docker agent
sudo usermod -aG lighttpd agent

sudo usermod -aG agent $(whoami)

cp agent/docker_agent.sh /usr/local/bin
cp agent/mcq_agent.sh /usr/local/bin

chown agent:agent /usr/local/bin/docker_agent.sh
chown agent:agent /usr/local/bin/mcq_agent.sh

cp agent/units/docker_agent.service /etc/systemd/system
cp agent/units/mcq_agent.service /etc/systemd/system

chmod 664 /etc/systemd/system/docker_agent.service
chmod 664 /etc/systemd/system/mcq_agent.service

cp agent/units/inginious_agents.conf /etc/sysconfig

systemctl daemon-reload
systemctl enable docker_agent.service
systemctl enable mcq_agent.service
