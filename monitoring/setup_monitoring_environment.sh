#!/bin/bash

export MONITOR_PATH="/datos/monitor" # Set monitoring path

echo -e "MONITOR_PATH=\"$MONITOR_PATH\"\n" | sudo tee -a /etc/environment
