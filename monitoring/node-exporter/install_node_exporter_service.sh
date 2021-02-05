#!/usr/bin/bash

NODE_V="1.0.1"

echo "Installing Node Exporter Version ${NODE_V}"
su - monitoring -c "cd ${MONITOR_PATH}; wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_V}/node_exporter-${NODE_V}.linux-amd64.tar.gz"
su - monitoring -c "cd ${MONITOR_PATH}; tar -zxvf node_exporter-${NODE_V}.linux-amd64.tar.gz; mv node_exporter-${NODE_V}.linux-amd64 node_exporter"
rm -rf ${MONITOR_PATH}/node_exporter-${NODE_V}.linux-amd64.tar.gz

echo "Creating node_exporter linux service"
sed 's@MONITOR_PATH@'${MONITOR_PATH}'@g' $DEPLOYMENT_HOME/monitoring/node-exporter/node_exporter.service > /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

echo "Estado node_exporter"
systemctl status node_exporter
lsof -i:9100
