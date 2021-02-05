# UNCode Monitoring

To monitor some metrics of the servers where UNCode is deployed, it can be installed some tools. Those tools are [Grafana](https://grafana.com/), [Prometheus](https://prometheus.io/), [Node Exporter](https://github.com/prometheus/node_exporter), [cAdvisor](https://github.com/google/cadvisor) and [Docker Metrics](https://docs.docker.com/config/daemon/prometheus/).
## Components
The structure of the components that make possible the monitoring are shown below.  
![Monitor Structure](assets/components.png)  
Prometheus collects the data from Node Exporter, cAdvisor and Docker Metrics. Data stored in Prometheus is queried by Grafana to show the information through Dashboards or to send Alerts via [email](https://grafana.com/docs/grafana/latest/alerting/notifications/#email) or via [Slack webhook](https://grafana.com/docs/grafana/latest/alerting/notifications/#slack).
Ports are configurable. 

## Installation 

### Server hosting frontend

Here is explained the step by step to install the components to monitor the server. 

1. Inside the Deployment folder, make the .sh files runnable:

   ```bash
   chmod +x monitoring/*.sh
   chmod +x monitoring/*/*.sh
   ```

2. Modify the environmental variable `MONITOR_PATH` with the path where you want to install the monitoring services. To do so, modify the file `$DEPLOYMENT_HOME/monitoring/setup_monitoring_environment.sh`.

3. Run the command `$DEPLOYMENT_HOME/monitoring/setup_monitoring_environment.sh` to set the environment variables.

4. Disable selinux

   `sudo $DEPLOYMENT_HOME/deployment_scripts/disable_selinux.sh`

   *Running this command will cause the server to restart automatically so that the changes are applied*

5. Install monitoring services `$DEPLOYMENT_HOME/monitoring/install_monitoring_services.sh`

6. Modify the var `GRAFANA_DOMAIN` in the file `$DEPLOYMENT_HOME/monitoring/grafana/install_grafana.sh` with the domain where grafana is hosted.

7. Install monitoring panel `$DEPLOYMENT_HOME/monitoring/install_monitoring_panel.sh`


8. (Optional) Update nginx config file

    ```bash
    location /monitoring/ {
      proxy_pass http://localhost:9091;
    }
    ```

### For other servers

1. Inside the Deployment folder, make the .sh files runnable:

   ```bash
   chmod +x monitoring/*.sh
   chmod +x monitoring/*/*.sh
   ```

2. Modify the environmental variable `MONITOR_PATH` with the path where you want to install the monitoring services. To do so, modify the file `$DEPLOYMENT_HOME/monitoring/setup_monitoring_environment.sh`.

3. Run the command `$DEPLOYMENT_HOME/monitoring/setup_monitoring_environment.sh` to set the environment variables.

4. Disable selinux

   `sudo $DEPLOYMENT_HOME/deployment_scripts/disable_selinux.sh`

   *Running this command will cause the server to restart automatically so that the changes are applied*

5. Install monitoring services `$DEPLOYMENT_HOME/monitoring/install_monitoring_services.sh`

6. Install nginx `$DEPLOYMENT_HOME/monitoring/deploy_nginx_server_monitoring.sh`

7. Update prometheus config in **the main server** in `$MONITOR_PATH/prometheus/prometheus.yml` under the `scrape_configs` option

```
  - job_name: 'node-exporter-remote'
    metrics_path: /node_exporter/metrics
    static_configs:
      - targets: ['35.226.138.8']
        labels:
          instance: 'grader-1'
      - targets: ['35.226...'] # Another target in case you want to monitor another server, for example another grader or the tools server.
        labels:
          instance: 'grader-2' # Change label
  - job_name: 'c-advisor-remote'
    metrics_path: /c_advisor/metrics
    static_configs:
      - targets: ['35.226.138.8'] # Add the remote server you want to monitor
      labels:
          instance: 'grader-1' # Change label
  - job_name: 'docker-remote'
    metrics_path: /docker/metrics
    static_configs:
      - targets: ['35.226.138.8'] # Add the remote server you want to monitor
      labels:
          instance: 'grader-1' # Change label
```

## Additional Configuration
### Graphs in the alerts
1. Install the image renderer plugin
    ```
    grafana-cli --pluginsDir \"${MONITOR_PATH}/grafana/plugins\" plugins install grafana-image-renderer
    ```
2. Install dependencies  
   Centos - RedHat
   ```
    yum install at-spi2-atk
    yum install libXScrnSaver
    yum install gtk3
   ```
```bash
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
```
 

### Dashboards
Two dashboards were build to show relevant information of UNCode ([General Dashboard](assets/monitoring/uncode_dashboard.json) and [Daily Reports Dashboard](assets/monitoring/uncode_reports.json)). They can be imported in Grafana after replace some fields. 
```bash
sed 's@SERVER_IP@'${SERVER_IP}'@g;s@GRAFANA_PORT@'${GRAFANA_PORT}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g;s@DMETRICS_PORT@'${DMETRICS_PORT}'@g' $DEPLOYMENT_HOME/monitoring/grafana/uncode_dashboard.json > ${MONITOR_PATH}/uncode_dashboard.json
sed 's@SERVER_IP@'${SERVER_IP}'@g;s@GRAFANA_PORT@'${GRAFANA_PORT}'@g;s@CADVISOR_PORT@'${CADVISOR_PORT}'@g;s@DMETRICS_PORT@'${DMETRICS_PORT}'@g' $DEPLOYMENT_HOME/monitoring/grafana/uncode_reports.json > ${MONITOR_PATH}/uncode_reports.json
```
### Final Configuration
In Grafana Webpage
1. Add prometheus as data source"
2. Add dashboards Ex. 1860 or 10566
3. Add notification channels (To send alerts)
