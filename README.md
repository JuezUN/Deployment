# dependencies
The files contained in this repository deploy the Judge on a server using Docker and Docker compose
----

To deploy the application run deploy.sh , the judge needs the following dependencies to be installed

* docker 1.13.0+
* docker-compose 1.13.0+
* mongodb v3.2 or greater

Also please make sure to grant docker use permissions to docker to the current user,
this can be achieved by creating a group called docker and adding the user to that group.

`$ sudo groupadd docker`
`$ sudo usermod -aG docker $USER`

# Usage
To deploy a production environment use the following command
`$ run.sh [-u]`

The flag -u must only be used when you want to update your current version of the judge. It will update the containers for all the micro services (if an update is available).

# Deployment_configuration
The Judge allows various levels of configuration, for starters you can choose
the directory where the judge will store data (tasks files, backups, and temporal files) to do so
you must change the environment variable `JUDGE_HOME` this can be performed from the `deployment_configuration.env`
file, by default this location is set to `tmp/Judge`.

The ports that docker binds to the host to communicate the Judge's micro services can be adjusted via the `deployment_configuration.env`
file, these ports are:

* INGINIOUS_PORT: INGInious front end service, default port 8080
* LINTER_PORT: linter service, default port 4567
* PYTHON_TUTOR_PORT: code visualizer, default port 8003
* COKAPI_PORT: code visualizer helper, default port 3000
* DB_PORT: database, default port 27017

# INGInious configuration
The front end of INGInious can be adjusted to the needs of the scenario, activating plugins as you need them. These changes can be made inside the `configuration.yaml` file.
