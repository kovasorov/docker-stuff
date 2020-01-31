# Neo CLI v2.9.2

[v2.9.2 - neo-cli-linux-x64.zip](https://github.com/neo-project/neo-cli/releases/download/v2.9.2/neo-cli-linux-x64.zip)

## Запуск контейнера

### mainnet

```Shell
docker run -dit -v -p 10331:10331 neo-data:/opt/neo-cli/myneodata <IMAGE_NAME>
```

### testnet

```Shell
docker run -dit -p 20331:20331 -v neo-data:/opt/neo-cli/myneodata <IMAGE_NAME> testnet
```

После запуска автоматически создаётся, если не был создан, и открывается кошелёк. Если сделать attach к контейнеру, будет доступна консоль neo-cli.

[Документация по neo-cli](http://docs.neo.org/en-us/node/cli/2.9.0/api.html)

## Порты

|                  |Main Net |Test Net |
|:-----------------|--------:|--------:|
|JSON-RPC via HTTPS|10331    |20331    |
|JSON-RPC via HTTP |10332    |20332    |
