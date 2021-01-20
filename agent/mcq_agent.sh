#!/bin/bash

# Service mcq_agent starts the `inginious-agent-mcq` program to run submissions

# The first parameter is the backendhost IP set in the `/etc/hosts` file
inginious-agent-mcq tcp://$(cat /etc/hosts | grep backendhost | awk '{print $1}'):2001
