#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "adding lighttpd to mongo and docker group"
usermod -aG docker lighttpd
usermod -aG mongod lighttpd

mkdir -p /var/www/INGInious
mkdir -p /var/www/INGInious/tasks
mkdir -p /var/www/INGInious/backup
mkdir -p /var/www/INGInious/tmp
chown -R lighttpd:lighttpd /var/www/INGInious

mkdir -p /var/cache/lighttpd/compress
chown -R lighttpd:lighttpd /var/cache/lighttpd/compress

cp $DEPLOYMENT_HOME/config/configuration.yaml /var/www/INGInious/

rm -rf /etc/lighttpd
cp -r $DEPLOYMENT_HOME/config/lighttpd /etc/

systemctl enable lighttpd
systemctl restart lighttpd
