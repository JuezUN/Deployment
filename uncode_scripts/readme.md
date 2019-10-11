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

This command is used to restart the web application, it restarts the services of **nginx**, **lighttpd** and **mongod**. 

Usage:

``` 
uncode_webapp_restart
```

## uncode_linter_restart

This command is used to **update and restart** the linter web service.

Usage: 

```
uncode_linter_restart
```

## uncode_tutor_restart

This command is used to update and restart the tutor services which are python-tutor, python-tutor-py2 and cokapi. 
python-tutor and python-tutor-py2 are deployed as a docker container while cokapi is deployed as a systemd service.

Usage: 

```
uncode_tutor_restart
```


## uncode_database_backup

This command is used to manage the backups of the database, with this command you can **create** a backup locally, **restore** a backup and **push** only the last backup in Google drive.

Currently, the backups are being stored using Google Drive, so you need to follow the steps described [here](https://github.com/JuezUN/INGInious/wiki/How-to-set-up-backups)
to set up the Google Drive credentials and *GDrive* program. 

Set up:
```
mkdir /path/to/databaseBakupDir/
```

Usage:

### Create 

Makes a snapshot of the current database and compresses it to a *.tar.gz* file, 
with the day and time as file name.

```
cd /path/to/databaseBakupDir/
uncode_database_backup create
```

### Restore
This command downloads the last backup from drive and restores the database with that data.

```
cd /path/to/databaseBakupDir/
uncode_database_backup restore
```

When the database is restored, the downloaded files are removed.

### Upload
Uploads the *.tar.gz* compressed file containing the database to Google Drive. 

```
cd /path/to/databaseBakupDir/
uncode_database_backup push
```

## uncode_tasks_backup

This command is used to manage the backups of the tasks, with this command you can **create** a backup, **push** it 
and **restore** a backup to the remote repository.

Currently, the backups are being stored using git, so you'll need to have access to the tasks backup private repository.

Set up:
```
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

```
uncode_tasks_backup create
```

This commit is not push it to the remote repository, please try `uncode_tasks_backup push`. 

### Push
Pushes the non pushed backups (commits) to the remote repository.


```
uncode_tasks_backup push
```

Depending on how you configured the access to the repo you'll may be asked for your username and password to be able to push to remote.

### Restore
This command has two behaviors

1. Takes whatever backup data you currently have in the HEAD of the repository and restores the tasks with that data.

    ```
    uncode_tasks_backup restore
    ```

2. Takes the backup at commit `COMMIT_HASH` and restores the tasks with that data.

    ```
    uncode_tasks_backup restore COMMIT_HASH
    ```

    **Note:** When you run this command, the repository is checked out to `COMMIT_HASH` commit. You might want to get it back to master or the old HEAD after executing it.

## uncode_update_server

This command updates the server with latest version of UNcode's INGInious. To use it just write the next command:

    ​```
    uncode_update_server
    ​```

This update can also be done with a branch adding the tag -b in command as follows:

    ​```
    uncode_update_server -b <branch_name>
    ​```

After installing the new packages, it restarts the webapp to make the server work with the new code.
