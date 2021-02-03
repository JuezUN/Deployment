#!/bin/bash

sudo yum install -y lighttpd lighttpd-fastcgi
sudo -H pip3.6 install "flup>=1.0.3.dev"
