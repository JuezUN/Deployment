# dependencies
The files contained in this repository deploy the Judge on a server using Docker and Docker compose
----

To deploy the application run deploy.sh , the judge needs the following dependencies to be installed

* docker
* docker-compose
* mongodb v3.2 or greater

Also please make sure to grant docker use permissions to docker to the current user,
this can be achieved by creating a group called docker and adding the user to that group.

`$ sudo groupadd docker`
`$ sudo usermod -aG docker $USER`

#Usage
To deploy a production environment use the following command
`$ run.sh [-pdltcbi]`

#flag description
The run.sh script can be run with the following flags:

  * `-p [path]` this flag is used to set the home path for the judge installation, such path will be used to store the tasks_directory
  and backup_directory as well as some temporal files that will be removed post installation.

please ensure that the home directory path has user privileges, if no path is provided the script will use `/opt/Judge`
as the home directory. To grant such privileges use the following command:

`$ sudo chown $USER <route_to_judge_home>`
