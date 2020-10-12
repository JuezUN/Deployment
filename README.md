# UNCode Deployment 

[![License](https://img.shields.io/github/license/JuezUN/Deployment?style=plastic)][license_url]
[![Contributors](https://img.shields.io/github/contributors/JuezUN/Deployment?style=plastic)][contributors_url]
[![GitHub issues](https://img.shields.io/github/issues/JuezUN/Deployment?style=plastic)][issues_url]
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/cb814cff25be4fb89e97be55aa29fbbf)][codacy_badge_url]
[![CLA assistant](https://cla-assistant.io/readme/badge/JuezUN/Deployment)][cla_url]
[![Gitter](https://badges.gitter.im/uncode-unal/community.svg)][gitter_url]

This repository contains all necessary scripts to automatically deploy UNCode with all of its features.
Here you'll find a step-by-step guide to deploy it in a **CentOS 7** server to be able to host your courses.

For more information, please refer to the project page: <https://juezun.github.io/UNCode_page>

## Before you start

Before you start, we recommend that you review the documentation of [proxy settings](proxy.md) and the documentation of [firewall settings](firewall.md). You can avoid problems related to the configuration of this modules by reading and applying the considerations mentioned there.

## Steps to deploy

1. Have a machine with CentOS 7 and git

2. Make sure that there is a password set for root and the user that will execute the scripts

3. Clone the deployment repository

   `git clone https://github.com/JuezUN/Deployment.git`

4. Inside the Deployment folder, make the .sh files runnable

   `chmod +x *.sh`

5. Disable selinux

   `sudo ./disable_selinux.sh`

   *Running this command will cause the server to restart automatically so that the changes are applied*

6. Install the prerequisites, you can use `./install_prerequisites.sh` to do this. 
   ​      
     *Make sure you DON'T run this command with sudo as the user is the one that should be able to use the applications (not sudo)*

   **Note**: Check the *File system docker driver* with `docker info`, this should say `overlay2`. If not, check bellow in common problems to fix this.

7. Logout and log back in to the server so that the user can use mongo and docker without `sudo`.

8. Run the command `./setup_environment.sh && source env.sh` to set the environment variables (such as proxy and ports used by the backend microservices).

9. Modify the `configuration.yaml` file to use the setup you want.
    - In `configuration.yaml` in the backend option, set it to `backend: tcp://127.0.0.1:2000`

If you want to **deploy the entire application in a single machine**, then

- Execute the script `./run.sh`

If you want to **deploy the tools in a separate machine** from the rest of the application, follow next steps if that is the case:

- In `/etc/nginx/conf.d/inginious.conf` file, change url to proxy the linter, tutor and cokapi services. Instead of proxy pass to localhost, it should have the url (IP or domain name). It should look as follows:

  ```
    location /cokapi/ {
      proxy_pass http://<IP or damain_name>/cokapi/;
    }

    location /linter/ {
      proxy_pass http://<IP or damain_name>/linter/;
    }

    location /tutor/ {
      proxy_pass http://<IP or damain_name>/tutor/;
    }
  
    location /tutor_py2/ {
      proxy_pass http://<IP or damain_name>/tutor_py2/;
    }
  ```

- Run the command `./run.sh --distributed-tools`. This parameter will tell the deployment to do not deploy tools services in the same machine.

- Go to [tools host deployment documentation](tools_host/README.md) to deploy this services in another services.

Go to [Grading host deployment documentation][grader_host_url] to deploy 
any number of hosts that will be used as grading machines, these grader machines will be attached 

**NOTE:** If you are deploying the agents and tools in separate machines, you can run the command `./run.sh --distributed --distributed-tools` with both parameters.

## Configuration

### Configuration.yaml

This file specifies which plugins will run when the judge deploys, also is needed that the settings for the SMTP server are set properly (i.e. username and password), if you want to.

### FastCGI.conf

File located in /etc/lighttpd/conf.d/fastcgi.conf, this file specifies the configuration related to fastcgi and the processes that lighttpd will create to handle requests.
The options to focus on are *max-procs* and *min-procs*, these options specify the processes that fastCGI will create. Here we recommend to leave the same value for both options, 
 as this will create an static number of process.

### Nginx

File located in /etc/nginx/conf.d/uncode.conf, this file specifies the reverse proxy rules that are processed by nginx,
Modify the server_name and the IP, as well as other settings you think should be configured.

### Python tutor and linter

Modify the `docker-compose.yml` file, which deploys these services, as you want. You can set different memory limits
 according to your necessities. 

## UNCode scripts

These are some helpful scripts or commands that will help on managing the server. If you want to know more about them please go to [uncode_scripts][uncode_scripts_url] and read the documentation inside it. You will learn how to restart the services, make automatic backups, among others.

## What to do if server reboots

### Manual reboot
When you reboot the server, you will see that the front end will work fine but if you try  to submit code it won't work. To fix that you just have to follow next few steps:

1. Go into the *Deployment* directory.
2. Run the command `./setup_environment.sh && source env.sh` to set the environment variables (such as proxy and ports used by the backend microservices).
3. If you are deploying the agent in a single machine, run the command `sudo bash deployment_scripts/build_all_containers.sh`
4. Run the command `uncode_webapp_restart`in order to restart all services and make everything work correctly.

You are all set, try submitting code and see if it works.

### Automatic reboot

You can create a cron job that executes at startup, so you don't have to worry setting the environment.

If you run the command `sudo crontab -e` to see the current crons. The cron job related to this process looks like:

```bash
@reboot (sleep 300; /usr/bin/uncode_process_after_reboot)
```

Where the first line defines the cron job to reboot the server and second cron will run on startup, it will sleep for 300  seconds while server finishes startup and then it runs the command `uncode_process_after_reboot`.

## Common problems

There are some problems that you might find when deploying the services. 

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

Project page: <https://juezun.github.io/UNCode_page/>

[grader_host_url]: https://github.com/JuezUN/Deployment/tree/master/grader-host
[uncode_scripts_url]: https://github.com/JuezUN/Deployment/tree/master/uncode_scripts
[license_url]: https://github.com/JuezUN/Deployment/blob/master/LICENSE
[contributors_url]: https://github.com/JuezUN/Deployment/graphs/contributors
[issues_url]: https://github.com/JuezUN/Deployment/issues
[codacy_badge_url]: https://www.codacy.com/gh/JuezUN/Deployment/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=JuezUN/Deployment&amp;utm_campaign=Badge_Grade
[cla_url]: https://cla-assistant.io/JuezUN/Deployment
[gitter_url]:https://gitter.im/uncode-unal/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge
[contributing_url]: https://github.com/JuezUN/Deployment/blob/master/CONTRIBUTING.md
