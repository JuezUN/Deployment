# Firewall configuration

It is recommended to run a firewall on your production systems. However, you might be deploying you application and found that it is not accessible anymore. To fix that,you need to open the ports of your machine.

The tool `firewalld` has a set of ports associated with well known services names for example http, https, ssh, ftp, etc. You can enable them.

For example to open http and https ports you can use the following commands

```
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
```

If you are running under distributed grading and webapp configuration, you'll need to open the port 2001 for the tcp protocol so that backend and agents can communicate You can do that with the following commands

```
sudo firewall-cmd --permanent --add-port=2001/tcp
sudo firewall-cmd --reload
```

For more information please refer to [firewalld documentation](https://firewalld.org/documentation/)

