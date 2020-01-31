# SNX-VPN + SSH

## Запуск контейнера

```Shell
docker run --rm --cap-add=NET_ADMIN -v /lib/modules:/lib/modules \
-v /dev:/dev \
-e SNX_SERVER=<server> \
-e SNX_USER=<user> \
-e SNX_PASSWORD=<password> \
-it snx-vpn
```

## Настройка gitlab-runner

Для встройки в пайплайн, необходимо настроить гитлабраннер.

В файл конфигурации `/etc/gitlab-runner/config.toml` добавить:

```Text
cap_add = ["NET_ADMIN"]
volumes = ["/lib/modules:/lib/modules", "/dev:/dev"]
```
