# Zcash v2.0.2

## сборка

```Shell
docker build -t zcash .
```

## main net

```Shell
docker run --rm --name zcash-server -p 8232:8232 -v zcash_main:/root zcash:latest -printtoconsole -rpcallowip=0.0.0.0/0 -rpcpassword=zcash -rpcuser=zcash -addnode=mainnet.z.cash
```

## test net

```Shell
docker run --rm --name zcash-server -p 18232:18232 -v test_params:/root/.zcash-params -v test_data:/root/.zcash zcash:latest testnet -printtoconsole -rpcallowip=0.0.0.0/0 -rpcpassword=zcash -rpcuser=zcash -testnet=1 -addnode=testnet.z.cash
```

## testnet faucet

v2.0.1 <https://faucet.testnet.z.cash/>

&copy; 2018
