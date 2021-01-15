#!/bin/bash

mkdir -p /var/www/INGInious
mkdir -p /var/www/INGInious/tasks

mount backendhost:/var/www/INGInious/tasks /var/www/INGInious/tasks

echo -e "backendhost:/var/www/INGInious/tasks /var/www/INGInious/tasks nfs     nosuid,rw,sync,hard,intr  0  0\n" | sudo tee -a /etc/fstab
