# Super Container

install package from container in host system

```Bash
docker run --priveleged sucont\
    -v /:/rootfs/ \
    -v /var/run/dbus:/var/run/dbus \
    -v /run/systemd:/run/systemd
```