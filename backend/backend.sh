#!/bin/bash

# Starts the backend module from UNCode

if [ -z "$BACKEND_HOST" ]
then
    echo -e "$(tput setaf 1)Variable BACKEND_HOST not defined $(tput sgr0)"
    exit 1
fi

# Set the Private IP of the main server, where the backend is located.
inginious-backend tcp://$BACKEND_HOST:2001 tcp://127.0.0.1:2000
