#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 2
fi

chmod +x monitoring/*/*.sh

# Monitoring user
echo "Creating user 'monitoring'"
sudo useradd -m -s /bin/bash monitoring
sudo usermod -aG monitoring $(whoami)

sudo mkdir -p ${MONITOR_PATH}
if [ $? -ne 0 ];
then
  echo "${MONITOR_PATH} cannot be created"
  exit 1
fi

chown monitoring ${MONITOR_PATH}

sudo yum install -y wget

echo "##################################################################################"

#################
# NODE EXPORTER #
#################

sudo $DEPLOYMENT_HOME/monitoring/node-exporter/install_node_exporter_service.sh

echo "##################################################################################"

#################
#### CADVISOR ###
#################

sudo $DEPLOYMENT_HOME/monitoring/cadvisor/install_c_advisor_service.sh

echo "##################################################################################"

#################
# DOCKER METRICS#
#################
if [ ! -f /etc/docker/daemon.json ];then
  sed 's@DMETRICS_PORT@'${DMETRICS_PORT}'@g' $DEPLOYMENT_HOME/monitoring/docker/daemon.json > /etc/docker/daemon.json
  systemctl restart docker
else
  echo "Add to /etc/docker/daemon.json and restart docker service"
  cat $DEPLOYMENT_HOME/monitoring/docker/daemon.json
fi
