# Proxy setting

Under some deployments, you'll need to set up the proxy service for everything to work correctly. It is recommended to set proxy for all users in the system. You can do this by editing the `/etc/environment` file.

For example

```
$ cat /etc/environment

http_proxy="http://myproxy.server.com:8080/"
https_proxy="http://myproxy.server.com:8080/"
no_proxy="localhost,127.0.0.1"
HTTP_PROXY="http://myproxy.server.com:8080/"
HTTPS_PROXY="http://myproxy.server.com:8080/"
NO_PROXY="localhost,127.0.0.1"
```

For more details see this [stackoverflow post](https://askubuntu.com/questions/175172/how-do-i-configure-proxies-without-gui).

# Docker proxy

When you run services using systemd, each service has its own environment variables, this includes docker, mongo, apache, and our custom systemd services. However, the only one that needs access to the internet is the docker service. You can see how to configure this on the following [tutorial](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy).
