#!/bin/bash

# Service docker_agent starts the `inginious-agent-docker` program to run submissions

# The first parameter is the backendhost IP and the second parameter is the concurrency which indicates how many
# cores will run submission concurrently.

number_cpus=$(($(nproc) - 1));

if [ "$number_cpus" -eq "0" ]; then
    number_cpus=1;
fi

inginious-agent-docker tcp://$(grep backendhost < /etc/hosts | awk 'NR==1{print $1}'):2001 --concurrency $number_cpus --debug-host $(hostname -I | awk 'NR==1{print $1}')
