#!/usr/bin/bash

CADVISOR_V="v0.35.0"

mkdir ${MONITOR_PATH}/cadvisor

chown -R monitoring:monitoring ${MONITOR_PATH}/cadvisor

sed 's@CADVISOR_V@'${CADVISOR_V}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g' $DEPLOYMENT_HOME/monitoring/cadvisor/docker-compose.yml > ${MONITOR_PATH}/cadvisor/docker-compose.yml
sed 's@MONITOR_PATH@'${MONITOR_PATH}'@g' $DEPLOYMENT_HOME/monitoring/cadvisor/uncode_cadvisor_start > /usr/bin/uncode_cadvisor_start

chmod 755 /usr/bin/uncode_cadvisor_start
/usr/bin/uncode_cadvisor_start
