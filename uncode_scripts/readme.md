# UNcode scripts documentation

## Installation

You can install this scripts to the system by running the command `sudo install_uncode_scripts.sh` on the root of the Deployment folder. 

Otherwise if you called `install_prerequisites.sh` script, they are already installed.

If you call the command again (with either option), the scripts will be updated with whatever version you have in the Deployment repository.

## uncode_status

Shows the output of the `top` command but filtered to the processes related with UNCode. It is useful for monitoring proposes.

Usage:

``` 
uncode_status
```

## uncode_full_restart

Restarts all the services that UNCode depends on, including the database, and the plugin services.

Usage:

``` 
uncode_full_restart
```

## uncode_webapp_restart

This command is used to restart the web application, it restarts the services of nginx, lighttpd and mongod. 

Usage:

``` 
uncode_webapp_restart
```

## uncode_linter_restart

This command is used to **update and restart** the linter web service. Important: the current working directory when executing this script must be the root of the Deployment repository folder because it contains the file `docker-compose.yml` which is needed by the script. If the image is already up to date, then it only restarts the service.

Usage: 

```
cd /path/to/Deployment/folder
uncode_linter_restart
```

## uncode_tutor_restart

This command is used to update and restart the tutor services which are python-tutor and cokapi. python-tutor is deployed as a docker container while cokapi is deployed as a systemd service.

Usage: 

```
cd /path/to/Deployment/folder
uncode_tutor_restart
```


## uncode_database_backup

This command is used to manage the backups of the database, with this command you can **create** a backup locally, **restore** a backup and **push** one or more backups to the remote repository.

Currently, the backups are being stored using git, so you'll need to have access to the database backup private repository.

Set up:
```
git clone https://gitlab.com/amrondonp/databasebackup
```

Or another private repository you are using for database backups.

Usage:

### Create 

Makes a snapshot of the current database and commits it with the day and time as commit name.

```
cd /path/to/databaseBakup/repo
uncode_database_backup create
```

### Restore
This command has two behaviors

1. Takes whatever backup data you currently have in the HEAD of the repository and restores the database with that data.

    ```
    cd /path/to/databaseBakup/repo
    uncode_database_backup restore
    ```

2. Takes the backup at commit `COMMIT_HASH` and restores the database with that data.

    ```
    cd /path/to/databaseBakup/repo
    uncode_database_backup restore COMMIT_HASH
    ```

    Note: When you run this command, the repository is checked out to `COMMIT_HASH` commit. You might want to get it back to master or the old HEAD after executing it.

### Push
Pushes the non pushed backups (commits) to the remote repository.


```
cd /path/to/databaseBakup/repo
uncode_database_backup push
```

Depending on how you configured the access to the repo you'll may be asked for your username and password to be able to push to remote.


