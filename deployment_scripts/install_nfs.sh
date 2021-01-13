#!/bin/bash

sudo yum install -y nfs-utils

sudo systemctl enable nfs-server rpcbind
sudo systemctl start nfs-server rpcbind
