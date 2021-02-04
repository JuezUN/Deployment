#!/usr/bin/bash

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
echo "ADDITIONAL INFORMATION"

echo "
In case you want to configure grafana alerting via email.
 Install grafana plugin:
      	grafana-cli --pluginsDir \"${MONITOR_PATH}/grafana/plugins\" plugins install grafana-image-renderer
 Install dependencies:
 	yum install at-spi2-atk
 	yum install libXScrnSaver
 	yum install gtk3
 Configure grafana.ini (SMTP) and restart prometheus service
Restart grafana-server service
	systemctl restart grafana-server
"
echo "##################################################################################"

#sed 's@SERVER_IP@'${SERVER_IP}'@g;s@GRAFANA_PORT@'${GRAFANA_PORT}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g;s@DMETRICS_PORT@'${DMETRICS_PORT}'@g' ./config_files/uncode_dashboard.json > ${MONITOR_PATH}/uncode_dashboard.json
#echo "Import the dashboard in grafana. It's available in ${MONITOR_PATH}/uncode_dashboard.json"

#sed 's@SERVER_IP@'${SERVER_IP}'@g;s@GRAFANA_PORT@'${GRAFANA_PORT}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g;s@DMETRICS_PORT@'${DMETRICS_PORT}'@g' ./config_files/uncode_reports.json > ${MONITOR_PATH}/uncode_reports.json
#echo "Import the dashboard of the reports in grafana. It's available in ${MONITOR_PATH}/uncode_reports.json"

echo "##################################################################################"
echo "##################################################################################"
echo "Now, configure your grafana server"
echo "   Add prometheus as data source"
echo "   Add dashboards Ex. 1860 or 10566"
echo "   Add notification channels"


