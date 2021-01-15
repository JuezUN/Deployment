#!/bin/bash

# Starts the docker-agent module from inginious
set -e

if [ -z "$BACKEND_HOST" ]
then
    echo -e "$(tput setaf 1)Variable BACKEND_HOST not defined $(tput sgr0)"
    exit 1
fi

# Set the Private IP of the main server, where the backend is located.
inginious-agent-docker tcp://$BACKEND_HOST:2001 --concurrency $(($(nproc) - 1))
