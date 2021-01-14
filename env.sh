#!/bin/bash

PROXY=""
export LINTER_PORT="4567"
export PYTHON_TUTOR_PORT="8003"
export PYTHON_PY2_TUTOR_PORT="8004"
export COKAPI_PORT="4000"
export DB_PORT="27017"
export UNCODE_DOMAIN="$(curl ifconfig.me)" # Set the domain name or IP of current server

if [ -n "$PROXY" ]
then
    export http_proxy="http://$PROXY"
    export https_proxy="https://$PROXY"
fi
