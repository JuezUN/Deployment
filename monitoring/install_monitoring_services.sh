#!/usr/bin/bash

SERVER_IP=$(hostname -I | awk 'NR==1{print $1}')
DMETRICS_PORT="9102"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 2
fi

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

echo "##################################################################################"

#################
# NODE EXPORTER #
#################

sudo $DEPLOYMENT_PATH/monitoring/node-exporter/install_node_exporter_service.sh

echo "##################################################################################"

#################
#### CADVISOR ###
#################

sudo $DEPLOYMENT_PATH/monitoring/cadvisor/install_c_advisor_service.sh

echo "##################################################################################"

#################
# DOCKER METRICS#
#################
if [ ! -f /etc/docker/daemon.json ];then
  sed 's@SERVER_IP@'${SERVER_IP}'@g;s@DMETRICS_PORT@'${DMETRICS_PORT}'@g' $DEPLOYMENT_PATH/monitoring/docker/daemon.json > /etc/docker/daemon.json
  systemctl restart docker
else
  echo "Add to /etc/docker/daemon.json and restart docker service"
  cat $DEPLOYMENT_PATH/monitoring/docker/daemon.json
fi
