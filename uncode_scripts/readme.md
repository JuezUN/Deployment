# UNcode scripts documentation

## uncode_webapp_restart

This command is used to restart the web application, it restarts the services of nginx, lighttpd and mongod. 

Usage:

``` 
sudo uncode_webapp_restart
```

Note that **sudo** is required because we are restarting system level services.

## uncode_linter_restart

This command is used to restart the linter web service. Important: the current working directory when executing this script must be the root of the Deployment repository folder because it contains the file `docker-compose.yml` which is needed by the script.

Usage: 

```
cd /path/to/Deployment/folder
uncode_linter_restart
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
Takes whatever backup data you currently have in the HEAD of the repository and restores the database with that data.

```
cd /path/to/databaseBakup/repo
uncode_database_backup restore
```

### Push
Pushes the non pushed backups (commits) to the remote repository.


```
cd /path/to/databaseBakup/repo
uncode_database_backup restore
```

Depending on how you configured the access to the repo you'll may be asked for your username and password to be able to push to remote.


