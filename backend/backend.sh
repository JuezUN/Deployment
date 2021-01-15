#!/bin/bash

# Starts the backend module from UNCode
inginious-backend tcp://$(cat /etc/hosts | grep backendhost | awk '{print $1}'):2001 tcp://127.0.0.1:2000
