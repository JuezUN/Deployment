# Deployment
The files contained in this repository deploy the Judge on a server using Docker and Docker compose
----

To deploy the application run deploy.sh (the execution permission must be granted), the judge needs the following dependencies to be installed

* docker
* docker-compose
* node 6.x.x or above
* mongodb
* python3
* python3-pip
* python3-dev
* libzmq-dev
* tidy

Also please make sure to grant docker use permissions to docker to the current user,
this can be achieved by creating a group called docker and adding the user to that group.
