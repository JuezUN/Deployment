Tools host deployment

The tools machine can be independently deployed and scaled without disturbing the web app deployment. In this machine will be deployed an Nginx service working as a reverse proxy to proxy the different incoming requests to the proper services. Linter and Python tutor deployed as a docker service plus cokapi service used by python tutor to process C++ code.

Steps to deploy a tools host

1. Have a machine with CentOS 7 and git installed sudo yum install git. 
2. Clone the deployment repository git clone https://github.com/JuezUN/Deployment.git.
3. Inside the Deployment folder, make the .sh files runnable
       cd Deployment
       chmod +x *.sh
4. Disable selinux
       sudo ./disable_selinux.sh
   Running this command will cause the server to restart automatically so that the changes are applied
5. Go again inside the Deployment folder, then run the command ./setup_environment.sh && source env.sh to set the environment variables (such as proxy and ports used by the microservices).
6. Go to the tools_host folder cd tools_host/.
7. Make the .sh files executable chmod +x *.sh.
8. Install the tools prerequisites with ./tools_prerequisites.sh.
9. Run the command ./deploy_tools.sh to deploy the linter, python tutor, cokapi and nginx services.
10. Edit the file /etc/nginx/conf.d/tools.conf adding the machine IP or domain name. Also, you may want to allow some specific IPs which can do requests to this server.  
    
