#!/usr/bin/bash

CADVISOR_V="v0.35.0"
CADVISOR_PORT="9101"

mkdir ${MONITOR_PATH}/cadvisor

sed 's@CADVISOR_V@'${CADVISOR_V}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g' $DEPLOYMENT_PATH/monitoring/cadvisor/docker-compose.yml > ${MONITOR_PATH}/cadvisor/docker-compose.yml
sed 's@MONITOR_PATH@'${MONITOR_PATH}'@g' $DEPLOYMENT_PATH/monitoring/cadvisor/uncode_cadvisor_start > /usr/bin/uncode_cadvisor_start

chmod 755 /usr/bin/uncode_cadvisor_start
/usr/bin/uncode_cadvisor_start
