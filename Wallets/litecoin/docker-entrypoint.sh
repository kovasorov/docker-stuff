#!/bin/sh
#
set -e

# постоянные параметры
defcmd="-conf=/home/litecoin/.litecoin/litecoin.conf -datadir=$LITECOIN_DATA -discover -printtoconsole -txindex -rpcbind=0.0.0.0 -rpcallowip=yourserver.ip/16 -rpcthreads=128"

# making datadir
mkdir -p "$LITECOIN_DATA"
chmod 700 "$LITECOIN_DATA"
chown -R litecoin "$LITECOIN_DATA"
echo "$0: setting data directory to $LITECOIN_DATA"

# cmd -> bash
if [ $(echo "$1") = "bash" ]; then 
  echo "starting bash"
  exec bash
fi

# cmd -> reindext
if [ $(echo "$1") = "reindext" ]; then 
  echo "starting reindex"
  exec su-exec litecoin litecoind -testnet -reindex -printtoconsole
fi

# cmd -> testnet user password
if [ $(echo "$1") = "testnet" ]; then 
  echo "starting testnet"
  exec su-exec litecoin litecoind $defcmd -$1 -rpcuser=$2 -rpcpassword=$3
fi

# cmd -> mainnet user password
if [ $(echo "$1") = "mainnet" ]; then 
  echo "starting mainnet"
  exec su-exec litecoin litecoind $defcmd -rpcuser=$2 -rpcpassword=$3
fi

# cmd -> reindexm
if [ $(echo "$1") = "reindexm" ]; then 
  echo "starting reindex"
  exec su-exec litecoin litecoind -reindex -printtoconsole
fi

# cmd -> mnsync
if [ $(echo "$1") = "mnsync" ]; then 
  echo "starting mnsync status"
  exec su-exec litecoin litecoin-cli mnsync status
fi