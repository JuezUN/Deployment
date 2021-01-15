#!/bin/bash

# Starts the docker-agent module from inginious

inginious-agent-docker tcp://$(cat /etc/hosts | grep backendhost | awk '{print $1}'):2001 --concurrency $(($(nproc) - 1))
