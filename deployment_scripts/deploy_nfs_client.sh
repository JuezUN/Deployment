#!/bin/bash

sudo bash $DEPLOYMENT_HOME/deployment_scripts/install_nfs.sh

mkdir -p /var/www/INGInious
mkdir -p /var/www/INGInious/tasks

mount backendhost:/var/www/INGInious/tasks /var/www/INGInious/tasks

echo "backendhost:/var/www/INGInious/tasks /var/www/INGInious/tasks nfs     nosuid,rw,sync,hard,intr  0  0\n" | sudo tee -a /etc/fstab
