#!/bin/bash
#this configures the docker http proxy environment variables to work

echo "updating containers"
  docker pull unjudge/linter-web-service
  docker pull unjudge/onlinepythontutor
  docker pull unjudge/cokapi