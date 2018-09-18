#!/bin/bash

# Starts the docker-agent module from inginious
set -e

inginious-backend tcp://0.0.0.0:2001 tcp://0.0.0.0:2000
