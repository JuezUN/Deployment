#!/bin/bash

# Starts the mcq-agent module from inginious
set -e

if [ -z "$BACKEND_HOST" ]
then
    echo -e "$(tput setaf 1)Variable BACKEND_HOST not defined $(tput sgr0)"
    exit 1
fi

inginious-agent-mcq tcp://$BACKEND_HOST:2001
