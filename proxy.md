# Proxy setting

Under some deployments, you'll need to set up the proxy service for everything to work correctly. It is recommended to set proxy for all users in the system. You can do this by editing the `/etc/environment` file.

For example

```
$ cat /etc/environment

http_proxy="http://myproxy.server.com:8080/"
https_proxy="https://myproxy.server.com:8080/"
no_proxy="localhost,127.0.0.1"
HTTP_PROXY="http://myproxy.server.com:8080/"
HTTPS_PROXY="https://myproxy.server.com:8080/"
NO_PROXY="localhost,127.0.0.1"
```

For more details see this [stackoverflow post](https://askubuntu.com/questions/175172/how-do-i-configure-proxies-without-gui).

# Services proxy

When you run services using systemd, each service has its own environment variables, this includes docker, mongo, lighttpd, and our custom systemd services. However, there are some few services that need access to the Internet. You can see how to configure this on the following [tutorial](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy).

- ### Docker proxy

  You can see how to configure this service on the following [tutorial](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy).


- ### Lighttpd proxy

  The configuration of Lighttpd proxy is quite similar to the docker service. Follow the next steps:

  1. Create a systemd drop-in directory for the lighttpd service:

     ```bash
     sudo mkdir -p /etc/systemd/system/lighttpd.service.d
     ```

  2. Create a file called `/etc/systemd/system/lighttpd.service.d/proxy.conf`that adds the `HTTPS_PROXY` environment variable.

     ```
     [Service]
     Environment="HTTPS_PROXY=https://myproxy.server.com:8080/"
     ```

  3. Flush changes:

     ```bash
     sudo systemctl daemon-reload
     ```

  4. Restart lighttpd:

     ```bash
     sudo systemctl restart lighttpd.service
     ```

  Now Lighttpd will have access to the Internet.

