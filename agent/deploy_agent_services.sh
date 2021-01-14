#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo -e "$UNCODE_DOMAIN   backendhost\n" | sudo tee -a /etc/hosts

# Create agent user and group
id -u agent > /dev/null 2>&1
if [ $? -ne 0 ]
then
    sudo useradd agent
fi

sudo usermod -aG agent agent
sudo usermod -aG docker agent
sudo usermod -aG lighttpd agent
sudo usermod -aG agent $(whoami)

cp $DEPLOYMENT_HOME/agent/docker_agent.sh /usr/local/bin
cp $DEPLOYMENT_HOME/agent/mcq_agent.sh /usr/local/bin

chown agent:agent /usr/local/bin/docker_agent.sh
chown agent:agent /usr/local/bin/mcq_agent.sh

cp $DEPLOYMENT_HOME/agent/units/docker_agent.service /etc/systemd/system
cp $DEPLOYMENT_HOME/agent/units/mcq_agent.service /etc/systemd/system

chmod 664 /etc/systemd/system/docker_agent.service
chmod 664 /etc/systemd/system/mcq_agent.service

sudo chmod 775 -R /var/www/INGInious

cp $DEPLOYMENT_HOME/agent/units/inginious_agents.conf /etc/sysconfig

systemctl daemon-reload
systemctl enable docker_agent.service
systemctl enable mcq_agent.service
