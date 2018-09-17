# Grading host(s) deployment

The grading machines can be independently deployed and scaled without disturbing the web app deployment. However, there is a piece of software that has to glue both components together. This component is called the *backend*

![Alt text](architecture.PNG?raw=true "Title")

As you can see in the diagram, *backend* is the piece of software that makes possible the interaction between the frontend and the grading hosts.

## Important

Due to design decisions The backend does not need to know the hostnames of the grading hosts. However, the grading hosts DO need to know the hostname of the backend and the port that it is listening to.

*That means that you need to provide in each and every grading host the hostname of the backend. Moreover, the backend should be deployed and listening BEFORE we deploy and run the grading host software*

Each agent registers itself to the backend and then the backend delegates the responsibility of grading submissions to them using a load balancing algorithm.

## Steps to deploy a grading host (agent)

0. Have a machine with CentOS 7 and git
1. Clone the deployment repo `git clone https://github.com/JuezUN/Deployment.git`
3. Inside the Deployment folder, make the .sh files runnable
    
    `chmod +x *.sh`

4. Disable selinux
    
    `sudo ./disable_selinux.sh`

    *Running this command will cause the server to restart automatically so that the changes are applied*

2. Go to the grader-host folder `cd ./Deployment/grader-host`
3. Make the .sh files executable `chmod +x *.sh`
3. Install the agent prerequisites with `./agent-prerequisites.sh`
4. *Logout and login again* so that you can use docker without sudo
5. Install the grading containers `sudo ../deployment_scripts/build_all_containers.sh`
5. Install the agent services with `./install-services.sh`
6. Make sure the BACKEND is running and you can see the its host
7. Run the services `systemctl start docker-agent` and `systemctl start mcq-agent`

8. To verify that the deployment was successful, check the logs on the backend machine service and verify that it registered the agents you just deployed.
