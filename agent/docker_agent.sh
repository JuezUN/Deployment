#!/bin/bash

# Service docker_agent starts the `inginious-agent-docker` program to run submissions

# The first parameter is the backendhost IP and the second parameter is the concurrency which indicates how many
# cores will run submission concurrently.

inginious-agent-docker tcp://$(cat /etc/hosts | grep backendhost | awk '{print $1}'):2001 --concurrency $(($(nproc) - 1))
