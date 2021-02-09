#!/bin/bash

GRAFANA_PORT="9091"
CADVISOR_PORT="9101"
DMETRICS_PORT="9102"
NODE_EXPORTER_PORT="9100"

MONITOR_PATH="/var/monitoring" # Set monitoring path

echo -e "export MONITOR_PATH=\"$MONITOR_PATH\"\n" | sudo tee -a /etc/environment
echo -e "export GRAFANA_PORT=\"$GRAFANA_PORT\"\n" | sudo tee -a /etc/environment
echo -e "export CADVISOR_PORT=\"$CADVISOR_PORT\"\n" | sudo tee -a /etc/environment
echo -e "export DMETRICS_PORT=\"$DMETRICS_PORT\"\n" | sudo tee -a /etc/environment
echo -e "export NODE_EXPORTER_PORT=\"$NODE_EXPORTER_PORT\"\n" | sudo tee -a /etc/environment
