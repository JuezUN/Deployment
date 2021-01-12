# Tools host deployment

The tools machine can be independently deployed and scaled without disturbing the web app deployment. In this machine will be deployed an **Nginx** service working as a reverse proxy to proxy the different incoming requests to the proper services. **Linter** and **Python tutor** deployed as a docker service plus **cokapi** service used by python tutor to process C++ code.

## Steps to deploy a tools host

1. Have a machine with CentOS 7 and git installed `sudo yum install git`. 

2. Clone the deployment repository `git clone https://github.com/JuezUN/Deployment.git`.

3. Inside the Deployment folder, make the .sh files runnable

   ```bash
   cd Deployment
   chmod +x *.sh
   ```

5. Modify the the environmental variable `UNCODE_DOMAIN` with the correct UNCode domain or IP. To do so, modify the file `env.sh`.

6. Run the command `../setup_environment.sh && source ../env.sh` to set the environment variables (such as proxy and ports used by the microservices).

7. Make the .sh files executable `chmod +x *.sh`.

8. Install the tools prerequisites with `./tools_prerequisites.sh`.

9. Run the command `./run.sh` to deploy the linter, python tutor, cokapi and nginx services.

10. Edit the file `/etc/nginx/conf.d/uncode_tools.conf` adding the machine IP or domain name. Also, you may want to allow some specific IPs which can do requests to this server.  

    ​