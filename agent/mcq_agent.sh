#!/bin/bash

# Service mcq_agent starts the `inginious-agent-mcq` program to run submissions

# The first parameter is the backendhost IP set in the `/etc/hosts` file
inginious-agent-mcq tcp://$(grep backendhost < /etc/hosts | awk 'NR==1{print $1}'):2001
