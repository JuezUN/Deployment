# Tools host deployment

The tools machine can be independently deployed and scaled without disturbing the web app deployment. In this machine will be deployed an **Nginx** service working as a reverse proxy to proxy the different incoming requests to the proper services. **Linter** and **Python tutor** deployed as a docker service plus **cokapi** service used by python tutor to process C++ code.

## Steps to deploy a tools host

1. Have a machine with CentOS 7 and git installed `sudo yum install git`. 

2. Clone the deployment repository `git clone https://github.com/JuezUN/Deployment.git`.

3. Inside the Deployment folder, make the .sh files runnable

   ```bash
   cd Deployment
   chmod +x *.sh
   chmod +x tools_host/*.sh
   ```

4. Modify the the environmental variable `UNCODE_DOMAIN` with the correct UNCode domain or IP. To do so, modify the file `env.sh`.

5. Run the command `./setup_environment.sh && source env.sh` to set the environment variables (such as proxy and ports used by the microservices).

6. Install the prerequisites, you can use `./tools_host/install_tools_prerequisites.sh` to do this. 
   ​      
    *Make sure you DON'T run this command with sudo as the user is the one that should be able to use the applications (not sudo)*

   **Note**: Check the *File system docker driver* with `docker info`, this should say `overlay2`. If not, check bellow in common problems to fix this.

7. Logout and log back in to the server so that the user can use mongo and docker without `sudo`.

8. Run the command `./tools_host/run.sh` to deploy the linter, python tutor, cokapi and nginx services.

9. Edit the file `/etc/nginx/conf.d/uncode_tools.conf` adding the machine IP or domain name. Also, you may want to allow some specific IPs which can do requests to this server.

10. Restart Nginx to load changes: `sudo service nginx restart`.