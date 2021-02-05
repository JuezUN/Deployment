#!/usr/bin/bash

PROM_V="2.21.0"

echo "Downloading Prometheus version ${PROM_V}"
su - monitoring -c "cd ${MONITOR_PATH}; wget https://github.com/prometheus/prometheus/releases/download/v${PROM_V}/prometheus-${PROM_V}.linux-amd64.tar.gz"
su - monitoring -c "cd ${MONITOR_PATH}; tar -zxvf prometheus-${PROM_V}.linux-amd64.tar.gz; mv prometheus-${PROM_V}.linux-amd64 prometheus"

sed 's@GRAFANA_PORT@'${GRAFANA_PORT}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g;s@DMETRICS_PORT@'${DMETRICS_PORT}'@g' $DEPLOYMENT_HOME/monitoring/prometheus/prometheus.yml > ${MONITOR_PATH}/prometheus/prometheus.yml
rm -rf ${MONITOR_PATH}/prometheus-${PROM_V}.linux-amd64.tar.gz

echo "Creating prometheus linux service"
sed 's@MONITOR_PATH@'${MONITOR_PATH}'@g' $DEPLOYMENT_HOME/monitoring/prometheus/prometheus.service > /etc/systemd/system/prometheus.service
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus

echo "Prometheus status"
systemctl status prometheus
lsof -i:9090