#!/bin/bash

PROXY=""
export LINTER_PORT="4567"
export PYTHON_TUTOR_PORT="8003"
export PYTHON_PY2_TUTOR_PORT="8004"
export COKAPI_PORT="3000"
export DB_PORT="27017"
if [ -n "$PROXY" ]
then
    export http_proxy="http://$PROXY"
    export https_proxy="https://$PROXY"
fi
