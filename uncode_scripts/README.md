# UNCode scripts documentation

## Installation

You can install this scripts to the system by running the command `sudo $DEPLOYMENT_HOME/deployment_scripts/install_uncode_scripts.sh` on the root of the Deployment folder. 

Otherwise if you called `install_prerequisites.sh` script, they are already installed.

If you call the command again (with either option), the scripts will be updated with whatever version you have in the Deployment repository.

## uncode_maintenance_window

This command activates a maintenance window page so users know when we are 
in maintenance. This page is shown via nginx.

Usage:

### Activate
To activate the maintenance window and show the page, run the command:

```bash
uncode_maintenance_window activate 
```

### Deactivate
To deactivate the maintenance window and stop showing the page, run the command:

```bash
uncode_maintenance_window deactivate 
```

## uncode_status

Shows the output of the `top` command but filtered to the processes related with UNCode. It is useful for monitoring proposes.

Usage:

```bash
uncode_status
```

## uncode_webapp_restart

This command is used to restart the web application, it restarts the services `nginx`, `lighttpd`, `agents`, `backend` and `mongo`. 

Usage:

```bash
uncode_webapp_restart
```

## uncode_agent_restart

This command is used to restart only the agent services, i.e. `docker_agent` and `mcq_agent`. This command is also available in the agent hosts.

Usage:

```bash
uncode_agent_restart
```

## uncode_linter_restart

This command is used to **update and restart** the linter web service.

Usage:

```bash
uncode_linter_restart
```

## uncode_tutor_restart

This command is used to update and restart the tutor services which are python-tutor and cokapi. 
python-tutor are deployed as a docker container while cokapi is deployed as a systemd service.

Usage:

```bash
uncode_tutor_restart
```

## uncode_tools_restart

This command is used to **update and restart** the linter and python tutor related web services.

Usage:

```bash
uncode_tools_restart
```

## uncode_update_tools

This command updates the server with latest version of UNCode tools containers for linter and python tutor

Usage:

```bash
uncode_update_tools
```

## uncode_database_backup

This command is used to manage the backups of the database, with this command you can **create**  and **upload** a backup
to Google Drive and **restore** the backup from Google drive.
Additionally, you can pass arguments to indicate if that backup is either manual or automatic.

A **manual** backup is when you want to create and upload a backup with a given name, you also are
able to create as many manual backups as you want.

An **Automatic** backup refers to those done by the crone job and only the last
backup is kept.  

Currently, the backups are being stored using Google Drive, so you need to follow the steps described [here](https://github.com/JuezUN/INGInious/wiki/How-to-set-up-backups)
to set up the Google Drive credentials and *GDrive* program. 

```bash
mkdir /path/to/databaseBakupDir/
```

Usage:

### Manual Create 

Makes a snapshot of the current database and compresses it to a *.tar.gz* file,
this receives an argument using the flag `-m` receiving the name you want to give to the backup.

```bash
cd /path/to/databaseBakupDir/
uncode_database_backup -m <backup_name> create
```

### Automatic create 

Makes a snapshot of the current database and compresses it to a *.tar.gz* file
using the current date as name. To indicate it is automatic, use the flag `-a`.

This creates and uploads the backup, also, deletes the last automatic backup.

```bash
cd /path/to/databaseBakupDir/
uncode_database_backup -a create
```

### Manual Restore
This command downloads the backup using the given id using the flag `-i-` from drive 
and restores the database with that data.

Replace the `<id_backup_to_restore>` with the file ID of the desired backup
you want to restore. To see all backups done run `gdrive list`.

```bash
cd /path/to/databaseBakupDir/
uncode_database_backup -i <id_backup_to_restore> restore
```

When the database is restored, the downloaded files are removed.

### Automatic restore
This command downloads the backup using the given taking the automatic backup using the
flag `-a` and restores the database with that data.

```bash
cd /path/to/databaseBakupDir/
uncode_database_backup -a restore
```

When the database is restored, the downloaded files are removed.

## uncode_tasks_backup

This command is used to manage the backups of the tasks, with this command you can **create** a backup, **push** it 
and **restore** a backup to the remote repository.

Currently, the backups are being stored using git, so you'll need to have access to the tasks backup private repository.

```bash
cd /var/www/INGInious/ #Location of tasks.
git init
git remote add origin https://gitlab.com/UNCode/tasks.git or the SSH URL
git config user.name "Your Name"
git config user.email you@example.com
```

Or another private repository you are using for tasks backups. 

**Note:** If you want to set up **automatic backups** take a look at this [documentation](https://github.com/JuezUN/INGInious/wiki/How-to-set-up-backups) on how to automatically do the backup.

Usage:

### Create 

Makes a snapshot of the current tasks, commits it with the day and time as commit name.

```bash
uncode_tasks_backup create
```

This commit is not push it to the remote repository, please try `uncode_tasks_backup push`. 

### Push
Pushes the non pushed backups (commits) to the remote repository.

```bash
uncode_tasks_backup push
```

Depending on how you configured the access to the repo you'll may be asked for your username and password to be able to push to remote.

### Restore
This command has two behaviors

1. Takes whatever backup data you currently have in the HEAD of the repository and restores the tasks with that data.

    ```bash
    uncode_tasks_backup restore
    ```

2. Takes the backup at commit `COMMIT_HASH` and restores the tasks with that data.

    ```bash
    uncode_tasks_backup restore COMMIT_HASH
    ```

    **Note:** When you run this command, the repository is checked out to `COMMIT_HASH` commit. You might want to get it back to master or the old HEAD after executing it.

## uncode_update_server

This command updates the server with latest version of UNcode. To use it just write the next command:

```bash
uncode_update_server
```

This update can also be done with a branch adding the tag -b in command as follows:

```bash
uncode_update_server -b <branch_name>
```

After installing the new packages, it restarts the webapp to make the server work with the new code.

## uncode_update_containers

This command updates the server with the latest version of UNCode grading containers.

Usage:

```bash
uncode_update_containers
```

## uncode_config_files_backup

Use this script to create backups of configuration files for a given server. This script copies some specific configuration files from the different services hosted by a given server. The files are copied to Git repository. Thus, you need to have a repository where you want to store the backed up files.

This script receives 4 mandatory parameters:

1. Path to the repository: this first parameter tells the script where to copy the files.
2. Server name: a name that you give to the server you are backing up. For example `main` or `grader-1`.
3. Server type: given that the same repository may be used to store config files from several servers, it is necessary to tell the script what kind of services are hosted in that server. Thus, you need to write either `main`, `grader` or `tools`, which are the kinds of services that can be deployed with UNCode.
4. A flag indicating whether to make a push or not.

These services or files are backed up:

- lighttpd (Only for main server).
- nginx (All servers).
- agent (Main and Grader servers).
- Backend (Main server).
- Grafana (Main server).
- Prometheus (Main server).
- configuration.yaml (Main server).

As seen in the list, the kind of service that is backed up, directly depends on the server type set in the third parameter.

To use this script, run the next command, replacing the parameters with the correct values:

```bash
uncode_config_files_backup /path/to/repository <server_name> <server_type (main/grader/tools)> <true/false>
```
