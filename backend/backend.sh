#!/bin/bash

# Starts the docker-agent module from inginious

# Set the Private IP of the main server, where the backend is located.
inginious-backend tcp://<Private IP>:2001 tcp://127.0.0.1:2000
