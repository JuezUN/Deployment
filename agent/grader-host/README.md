# UNCode - Grading host(s) deployment

The grading machines can be independently deployed and scaled without disturbing the webapp deployment. However, there is a piece of software that has to glue both components together. This component is called `backend`.

![UNCode's architecture](architecture.PNG?raw=true "Title")

As you can see in the diagram, the `backend` is the piece of software that makes possible the interaction between the frontend and the grading hosts.

**IMPORTANT**

Due to design decisions The backend does not need to know the hostnames of the grading hosts. However, the grading hosts DO need to know the hostname of the backend and the port that it is listening to. *That means that you need to provide in each and every grading host the hostname of the backend*.

Each agent registers itself to the backend and then the backend delegates the responsibility of grading submissions to them using a load balancing algorithm.

*If the `backend` dies, the registered agents don't have a way to know that they are not going to receive more work to do. You need to put `backend` up again and restart the agent services.*

## Deployment

### Changes on main server

It is necessary to share the tasks folder with the grading hosts so the services have access to this file system to run submissions. For that, a NFS service is deployed to share this folder, run next command in the server where the frontend is located: 
    
```bash
sudo $DEPLOYMENT_HOME/deployment_scripts/add_grader_server.sh
```

### Steps to deploy a grading host (agent)

0. Have a machine with CentOS 7 and git: `sudo yum install -y git`.
1. Clone the deployment repo `git clone https://github.com/JuezUN/Deployment.git`
3. Inside the Deployment folder, make the .sh files runnable
    
    ```bash
    chmod +x *.sh
    chmod +x -R agent/*.sh
    ```

4. Run the command `./setup_environment.sh && source env.sh` to set the environment variables (such as ports used by the different microservices).

5. Add `X.X.X.X backendhost` to your `/etc/hosts` file where `X.X.X.X` is the IP address of the backend, for example 

    ```
    $ nano /etc/hosts
    127.0.0.1   localhost localhost.localdomain
    ::1         localhost localhost.localdomain
    10.142.0.3 backendhost
    ```
    
    To check the IP of the main server, run `hostname -I | awk '{print $1}'`.

6. Install the agent prerequisites with `$DEPLOYMENT_HOME/agent/grader-host/agent_prerequisites.sh`

7. Disable selinux

   ```bash
   sudo ./deployment_scripts/disable_selinux.sh
   ```

   *Running this command will cause the server to restart automatically so that the changes are applied*

8. Install the agent services with `sudo $DEPLOYMENT_HOME/agent/grader-host/install_services_host.sh`
    
    Make sure the `backend` service is running in the main server and you can see the its host.

9. To verify that the deployment was successful, check the logs on the machine where the `backend service is running and verify that it registered the agents you just deployed. It should look something like the following lines, which indicate that the agents said 'hello' to the backend and everything is ready to use.

    ```bash
    $ journalctl -b -u backend | grep hello
    
    2018-09-17 23:26:32,626 - inginious.backend - INFO - Agent b'\x00k\x8bEi' () said hello
    2018-09-17 23:26:33,305 - inginious.backend - INFO - Agent b'\x00k\x8bEj' () said hello
    ```
