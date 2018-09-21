# Secure Shell File System (sshfs)

[sshfs](https://linux.die.net/man/1/sshfs) is a program that allows file sharing via ssh. For example, you can share a directory from a server to other server, the only requirement is that the client needs to be able to login to the server via ssh.

In our use case, we need to set up a network file sharing system to allow the agents to get the tasks files such as tests cases and grader programs. 

Once you have deployed the grading agent, you can proceed to mount this share folder on the grader machine.

## Steps to setup a shared folder

sshfs by default only allows access to the shared resources to the *user that mounted the directory*. However, in our set up we have our `agent` user that is the one who runs the grading services on the grading machine, so we need to configure sshfs to allow other users to access the directory.

* Modify the file `/etc/fuse.conf` and add the line `user_allow_other` 

```
$ cat /etc/fuse.conf

# mount_max = 1000
user_allow_other
```

This will allow the agent user to access the resource.

* Create the mount point

    `mkdir -p /var/agent/tasks`

Make sure that the user who is going to mount the folder and the `agent` user have write access to this mount point.

* Mount the folder.

    `sshfs user@backendhost:/var/www/INGInious/tasks /var/agent/tasks/ -o allow_other`

where `user` is a user with read access to the folder `/var/www/INGInious/tasks` on the webapp machine.

It'll ask for a password to login via ssh unless you have previously set up authentication keys.

Once you do that, you can verify that the folder is correctly mounted: if you do `cd /var/agent/tasks`, you should same the contents of the folder `/var/www/INGInious/tasks` of the webapp machine.  

After this, The agent is ready to grade the student submissions

*NOTE: you'll have to mount again the folder if the client reboots, we currently haven't tested a way to permanently mount the folder, but you can try to set it up.* 
