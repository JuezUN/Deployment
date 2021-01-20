#!/bin/bash

# Starts the backend program from UNCode which listens for connections in the IP given by `backendhost` in `/etc/hosts`.
inginious-backend tcp://$(cat /etc/hosts | grep backendhost | awk '{print $1}'):2001 tcp://127.0.0.1:2000
