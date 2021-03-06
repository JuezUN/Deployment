# UNCode - Tools host deployment

The tools machine can be independently deployed and scaled without disturbing the webapp deployment. In this machine will be deployed an **Nginx** service working as a reverse proxy to proxy the different incoming requests to the proper services. **Linter** and **Python tutor** deployed as a docker service plus **cokapi** service used by python tutor to process C++ code.

## Steps to deploy the tools host

1. Have a machine with CentOS 7 and git installed `sudo yum install -y git`. 

2. Clone the deployment repository `git clone https://github.com/JuezUN/Deployment.git`.

3. Inside the Deployment folder, make the .sh files runnable

   ```bash
   chmod +x *.sh
   chmod +x tools_host/*.sh
   chmod +x deployment_scripts/*.sh
   ```

4. Modify the environmental variable `UNCODE_DOMAIN` with the correct UNCode domain or IP. To do so, modify the file `env.sh`.

5. Run the command `./setup_environment.sh && source env.sh` to set the environment variables (such as proxy and ports used by the microservices).

6. Disable selinux

   `sudo ./deployment_scripts/disable_selinux.sh`

   *Running this command will cause the server to restart automatically so that the changes are applied*

7. Install the prerequisites, you can use `./tools_host/install_tools_prerequisites.sh` to do this. 
   ​      
    *Make sure you DON'T run this command with sudo as the user is the one that should be able to use the applications (not sudo)*

   **Note**: Check the *File system docker driver* with `docker info`, this should say `overlay2`. If not, check bellow in common problems to fix this.

8. Logout and log back in to the server so that the user can use mongo and docker without `sudo`.

9. Edit the file `./tools_host/config/nginx/uncode_tools.conf` adding the machine IP or domain name. Also, you may want to allow some specific IPs which can do requests to this server.

10. Run the command `./tools_host/run.sh` to deploy the linter, python tutor, cokapi and nginx services.

11. Test the tools that they are working from UNCode.

## Common Problems

- Check the firewall rules. See the [documentation](firewall.md) we have wrote about this to allow some ports and services. See that the `http` service is available, otherwise set this service.
- See if you are behind a proxy. See the [documentation](../proxy.md) for more information, to setup docker for example.
