#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Restarting uncode..."

echo "Restarting lighttpd 1/3"
service lighttpd restart

echo "Restarting nginx 2/3"
service nginx restart

echo "Restarting mongod 3/3"
service mongod restart

echo "Uncode restarted successfully"
