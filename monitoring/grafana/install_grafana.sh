#!/usr/bin/bash

GRAF_V="7.1.5-1"

GRAFANA_PORT="9091"
GRAFANA_DOMAIN="uncode.unal.edu.co"
GRAFANA_URL="monitoring"

echo "Installing Grafana monitoring panel"
wget https://dl.grafana.com/oss/release/grafana-${GRAF_V}.x86_64.rpm
yum localinstall grafana-${GRAF_V}.x86_64.rpm
rm -rf grafana-${GRAF_V}.x86_64.rpm

sed 's@MONITOR_PATH@'${MONITOR_PATH}'@g;s@GRAFANA_PORT@'${GRAFANA_PORT}'@g;s@GRAFANA_DOMAIN@'${GRAFANA_DOMAIN}'@g;s@GRAFANA_URL@'${GRAFANA_URL}'@g' $DEPLOYMENT_HOME/monitoring/grafana/grafana.ini > /etc/grafana/grafana.ini
cp -rp /var/lib/grafana/ ${MONITOR_PATH}
systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server
