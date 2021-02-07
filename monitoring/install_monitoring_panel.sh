#!/usr/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 2
fi

chmod +x monitoring/*/*.sh

###### CONFIG ######

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
## PROMETHEUS ###
#################

sudo $DEPLOYMENT_HOME/monitoring/prometheus/install_prometheus.sh

echo "##################################################################################"

#################
#### GRAFANA ####
#################

sudo $DEPLOYMENT_HOME/monitoring/grafana/install_grafana.sh

echo "##################################################################################"
echo "##################################################################################"
echo "Now, configure your grafana server"
echo "   Add prometheus as data source"
echo "   Add dashboards Ex. 1860 or 10566"
echo "   Add notification channels"


