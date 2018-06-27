#!/bin/bash

echo "installing problem-bank react"
if [ -n $http_proxy ]
then
  sudo npm config set proxy $http_proxy
  sudo npm config set https-proxy $https_proxy
fi

sudo npm install --prefix /usr/lib/python3.5/site-packages/inginious/frontend/plugins/problem_bank/react_app/
sudo npm run build --prefix /usr/lib/python3.5/site-packages/inginious/frontend/plugins/problem_bank/react_app/