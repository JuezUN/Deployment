# Deployment

Steps to deploy the server using Apache

1. Check that selinux is deactivated
2. Make sure that there is a password set for root and the user that will execute the scripts
3. Install the prerequisites, you can use `install_prerequisites.sh` to do this.
4. logout and log back in to the server so that the user can use mongo without `sudo`.
5. run the command `source init.sh` to set the environment variables (such as proxy and ports used by the backend microservices).
6. modify the `configuration.yaml` file to use the setup you want.
7. execute the script `./run`
