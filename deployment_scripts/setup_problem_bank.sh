#!/bin/bash

echo "Building problem-bank plugin"
if [ -n "$http_proxy" ]
then
  sudo npm config set proxy $http_proxy
  sudo npm config set https-proxy $https_proxy
fi

sudo npm install --prefix /usr/local/lib/python3.6/site-packages/inginious/frontend/plugins/problem_bank/react_app/
sudo npm run build --prefix /usr/local/lib/python3.6/site-packages/inginious/frontend/plugins/problem_bank/react_app/