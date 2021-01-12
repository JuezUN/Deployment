#!/bin/bash

echo "Setting up metabse"

rm -rf ~/metabase-db
mkdir ~/metabase-db
cp $DEPLOYMENT_HOME/metabase/config/*.db ~/metabase-db/
docker-compose -f $DEPLOYMENT_HOME/metabase/docker-compose.yml up -d #TODO: Set limits to container
