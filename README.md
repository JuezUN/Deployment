# Deployment
The files contained in this repository deploy the Judge on a server using Docker and Docker compose
----

To deploy the application run deploy.sh (the execution permission must be granted), the judge needs the following dependencies to be installed

they can be installed on any debian distribution via the following command:
  * docker
  * mongodb
  * python3
  * python3-pip
  * python3-dev
  * libzmq-dev
  * tidy

`sudo apt-get -y install docker docker.io mongodb gcc tidy python3 python3-pip python3-dev libzmq-dev`
