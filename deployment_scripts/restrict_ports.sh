#!/bin/bash

#this script closes port access from outside the server, please make sure that the following environment variables are set
#LINTER_PORT
#PYTHON_TUTOR_PORT
#COKAPI_PORT
#DB_PORT

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

function close_port{
    iptables -A INPUT -p tcp -s localhost --dport $1 -j ACCEPT
    iptables -A INPUT -p tcp  --dport 8003 -j DROP
}

function close_judge_ports{
    close port $LINTER_PORT
    close port $COKAPI_PORT
    close port $DB_PORT
}