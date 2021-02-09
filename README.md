# UNCode Deployment 

[![License](https://img.shields.io/github/license/JuezUN/Deployment?style=plastic)][license_url]
[![Contributors](https://img.shields.io/github/contributors/JuezUN/Deployment?style=plastic)][contributors_url]
[![GitHub issues](https://img.shields.io/github/issues/JuezUN/Deployment?style=plastic)][issues_url]
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/cb814cff25be4fb89e97be55aa29fbbf)][codacy_badge_url]
[![CLA assistant](https://cla-assistant.io/readme/badge/JuezUN/Deployment)][cla_url]
[![Gitter](https://badges.gitter.im/uncode-unal/community.svg)][gitter_url]

This repository contains all necessary scripts to automatically deploy UNCode with all of its features.
Here you'll find a step-by-step guide to deploy it in a **CentOS 7** server to be able to host your courses.

For more information, please refer to the project page: <https://juezun.github.io>

## Before you start

Before you start, we recommend that you review the documentation of [proxy settings](proxy.md) and the documentation of [firewall settings](firewall.md). You can avoid problems related to the configuration of this modules by reading and applying the considerations mentioned there.

## Steps to deploy

These steps will deploy the frontend services and the services to run submissions

1. Have a machine with CentOS 7 and git: `sudo yum install -y git`

2. Make sure that there is a password set for root and the user that will execute the scripts

3. Clone the deployment repository

   `git clone https://github.com/JuezUN/Deployment.git`

4. Inside the Deployment folder, make the .sh files runnable:

   ```bash
   chmod +x *.sh
   chmod +x deployment_scripts/*.sh
   ```

5. Run the command `./setup_environment.sh && source env.sh` to set the environment variables (such as ports used by the different services).

6. Disable selinux

   `sudo ./deployment_scripts/disable_selinux.sh`

   *Running this command will cause the server to restart automatically so that the changes are applied*

7. Install the prerequisites, run `./install_prerequisites.sh` to do this. 
   ​      
    *Make sure you DON'T run this command with sudo as the user is the one that should be able to use the applications (not sudo)*

   **Note**: Check the *File system docker driver* with `docker info`, this should say `overlay2`. If not, check bellow in common problems to fix this.

8. Logout and log back in to the server so that the user can use mongo and docker without `sudo`.

9. Modify the `configuration.yaml` file to use the setup you want, this is in the folder `config`. In the backend option, set it to `backend: tcp://127.0.0.1:2000`, in the `multilang` plugin options, set the IP or domain corresponding to this machine.
    For more information, see the [Documentation][config_reference].

10. Modify the config file of `Nginx` in `config/nginx/conf.d/uncode.conf` with the correct modifications and IP

11. Modify the config file of `lighttpd` in `config/lighttpd/conf.d/fastcgi.conf` setting the `max-procs` and `min-procs` that match the number of cores in your server and both values most be equal. 

12. Execute the script `./run.sh`.

13. (Optional) Now you will access to UNCode in the specified domain name or IP. In case you want to download a test course and set it up, run: `./deployment_scripts/add_test_course.sh`.

### Deploy linter and python tutor

In previous steps, you have deployed the necessary services to run submissions on UNCode, as well as the frontend. However, if you want to install the linter and python tutor services (tools), here there are two options:

- If you want to deploy these tools within the same machine, run the command `./tools_host/deploy_tools.sh` to deploy them. There are not any additional settings to be done.

- If you want to **deploy the tools in a separate machine** from the rest of the application, follow next steps:
    1. In `/etc/nginx/conf.d/uncode.conf` file, change the url to proxy the linter, tutor and cokapi services. Instead of proxy pass to localhost, set the domain name or IP of the server where you are deploying these tools. It should look as follows:

        ```
        location /cokapi {
          proxy_pass http://<IP or damain_name tools machine>/cokapi;
        }
        
        location /linter {
          proxy_pass http://<IP or damain_name tools machine>/linter;
        }
        
        location /tutor {
          proxy_pass http://<IP or damain_name tools machine>/tutor;
        }
        ```
    
    2. Modify the `configuration.yaml` file in `/var/www/INGInious/` in the `multilang` plugin, setting the IP or Domain name of this server, **NOT** the tools machine.
    
    3. Restart the services with `uncode_webapp_restart`.
    
    4. Go to [tools host deployment documentation](tools_host/README.md) to deploy these services in another server.

### Add additional grading machines

In case you want to add more machines to grade more submissions concurrently, go to [Grading host deployment documentation][grader_host_url] to deploy any number of hosts that will be used as grading machines.

### Deploy metabase

Metabase is a service for data analytics. This is connected to the UNCode's database, that is why you must deploy this service within the same machine.

1. Run the commands:
    ```bash
    chmod +x ./metabase/*.sh
    ./metabase/deploy_metabase.sh
    ```

2. Modify the file `/etc/nginx/conf.d/uncode.conf` and add the next proxy rules

    ```bash
    location /metabase/ {
        proxy_pass http://localhost:3000/;
    }
    
    location /app/ {
        proxy_pass http://localhost:3000/;
    }
    ```

3. Restart nginx with `sudo service nginx restart`

4. You will access metabase in the path `/metabase` from your browser.

### Deploy Mongo express

Mongo express is a service deployed with docker to graphically access to the Mongo DB. Deploy this service in the same machine where the DB is stored.

1. Run the next command and set a username and password to Mongo Express as indicated when running the script.
    ```bash
    sudo bash $DEPLOYMENT_HOME/deployment_scripts/deploy_mongo_express.sh
    ```

2. Modify the file `/etc/nginx/conf.d/uncode.conf` and add the next proxy rule:

    ```bash
    location /mongo_express/ {
        proxy_pass http://localhost:8081;
    }
    ```

3. Restart nginx with `sudo service nginx restart`

4. You will access Mongo Express in the path `/mongo_express` from your browser.

### Install monitoring services

In order to have a constant monitoring of your different server and services, it is very useful to install a control panel, as well as some services that constantly collect metrics from them. In case you want to install monitoring services, go to the [Monitoring documentation](monitoring/README.md).

## Configuration

### Configuration.yaml

File deployed in `/var/www/INGInious`.

This file specifies which plugins will run when UNCode deploys, set the options you think you need, as well as the corresponding plugins. See the [configuration reference][config_reference].

Every time this file is modified you must restart lighttpd service to load changes.

### FastCGI.conf

File located in `/etc/lighttpd/conf.d/fastcgi.conf`. This file specifies the configuration related to fastcgi and the processes that lighttpd will create to handle requests.
The options to focus on are `max-procs` and `min-procs`, these options specify the processes that fastCGI will create. Here we recommend to leave the same value for both options, as this will create an static number of process.

### Nginx

Main configuration file: `/etc/nginx/conf.d/uncode.conf`. This file specifies the reverse proxy rules that are processed by nginx,
Modify the server_name and the IP, as well as other settings you think should be configured.

### Python tutor and linter

Modify the `$DEPLOYMENT_HOME/docker-compose.yml` file, which deploys these services, as you want. You can set different memory limits according to your necessities. 

## UNCode scripts

These are some helpful scripts or commands that will help on managing the server. If you want to know more about them please go to [uncode_scripts][uncode_scripts_url] and read the documentation inside it. You will learn how to restart the services, make automatic backups, among others.

## What to do if server reboots

When server reboots, you will see that the frontend will work fine but if you try to submit code it won't work. To fix this, follow next few steps:

1. Run the command `$DEPLOYMENT_HOME/setup_environment.sh && source env.sh` to set the environment variables (such as proxy and ports used by the backend services).
2. Run the command `sudo bash $DEPLOYMENT_HOME/deployment_scripts/build_all_containers.sh`
3. Run the command `uncode_webapp_restart` in order to restart all services and load changes.

You are all set, try submitting code and test the different services.

## Common problems

There are some problems that you might find when deploying the services. 

- Check the firewall rules. See the [documentation](firewall.md) we have wrote about this to allow some ports.
- Docker compose says that the ports of the micro services are not specified. Solution: Make sure you run the command `source env.sh`
- Docker file system driver should be `overlay2`, to check the config of docker, run `docker info` and the `Storage docker` should say overlay2. In case it is not the case, check the docker [documentation](https://docs.docker.com/storage/storagedriver/overlayfs-driver/) to change the File system docker driver.
- Mongo DB fails to start after a reboot. There is an unsolved issue with systemd and mongod service that prevents it from starting correctly at boot. Until this issue is solved, the following workaround will start mongodb as INGInious needs.
  `sudo mongod -f /etc/mongod.conf`
- If you copy files into the **tasks** folder, the owner of new files may be different of *ligttpd* so you must change the owner of these files. For that, run the next command recursively on all the files inside **tasks** folder: `sudo chown -R lighttpd:lighttpd /var/www/INGInious/tasks/*`.

## Contributing

Go to [CONTRIBUTING][contributing_url] to see the guidelines and how to start contributing to UNCode.

## License

Distributed under the AGPL-3.0 License. See [LICENSE][license_url] for more information.

## Contact

In case of technical questions, please use the [gitter communication channel][gitter_url].

In case you want to host your course on our deployment, email us on: <uncode_fibog@unal.edu.co>

UNCode: <https://uncode.unal.edu.co>

Project page: <https://juezun.github.io/>

[grader_host_url]: https://github.com/JuezUN/Deployment/tree/master/agent/grader-host
[uncode_scripts_url]: https://github.com/JuezUN/Deployment/tree/master/uncode_scripts
[license_url]: https://github.com/JuezUN/Deployment/blob/master/LICENSE
[contributors_url]: https://github.com/JuezUN/Deployment/graphs/contributors
[issues_url]: https://github.com/JuezUN/Deployment/issues
[codacy_badge_url]: https://www.codacy.com/gh/JuezUN/Deployment/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=JuezUN/Deployment&amp;utm_campaign=Badge_Grade
[cla_url]: https://cla-assistant.io/JuezUN/Deployment
[gitter_url]:https://gitter.im/uncode-unal/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge
[contributing_url]: https://github.com/JuezUN/Deployment/blob/master/CONTRIBUTING.md
[config_reference]: https://github.com/JuezUN/INGInious/wiki/Configuration-reference