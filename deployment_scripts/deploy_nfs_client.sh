#!/bin/bash

# Script to deploy a new nfs client service which automatically mounts the shared folder. This folder corresponds to
# the tasks file system.

mkdir -p /var/www/INGInious
mkdir -p /var/www/INGInious/tasks

mount backendhost:/var/www/INGInious/tasks /var/www/INGInious/tasks

echo -e "backendhost:/var/www/INGInious/tasks /var/www/INGInious/tasks nfs     nosuid,rw,sync,hard,intr  0  0\n" | sudo tee -a /etc/fstab
