#!/bin/bash

echo "Setting up metabase service with Docker"

rm -rf ~/metabase-db
mkdir ~/metabase-db
cp "$DEPLOYMENT_HOME/metabase/config/*.db" ~/metabase-db/
docker-compose --compatibility -f "$DEPLOYMENT_HOME/metabase/docker-compose.yml" up -d
