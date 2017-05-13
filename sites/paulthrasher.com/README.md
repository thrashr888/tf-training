### systemd

It is assumed that:

* system user/group "caddy" exists
* caddy binary is located at /opt/caddy/caddy
* caddy user has rights to execute /opt/caddy/caddy
* Caddyfile is located at /etc/caddy/Caddyfile
* caddy user has read rights to /etc/caddy/Caddyfile
* caddy user has write rights to /var/run/caddy/ 

```
chmod 644 /etc/systemd/system/caddy.service
systemctl enable caddy.service
systemctl start caddy.service
systemctl status caddy.service
```
