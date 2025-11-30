#!/bin/sh
#
set -e

# постоянные параметры
defcmd="-conf=/bitcoin/bitcoin.conf -datadir=$BITCOIN_DATA -discover -printtoconsole -txindex -rpcbind=0.0.0.0 -rpcallowip=yourserver.ip/16 -rpcthreads=128"

# making datadir
mkdir -p "$BITCOIN_DATA"
chmod 700 "$BITCOIN_DATA"
chown -R bitcoin "$BITCOIN_DATA"
echo "$0: setting data directory to $BITCOIN_DATA"

# cmd -> bash
if [ $(echo "$1") = "bash" ]; then 
  echo "starting bash"
  exec bash
fi

# cmd -> reindext
if [ $(echo "$1") = "reindext" ]; then 
  echo "starting reindex"
  exec su-exec bitcoin bitcoind -testnet -reindex
fi

# cmd -> testnet user password
if [ $(echo "$1") = "testnet" ]; then 
  echo "starting testnet"
  exec su-exec bitcoin bitcoind $defcmd -$1 -rpcuser=$2 -rpcpassword=$3
fi

# cmd -> mainnet user password
if [ $(echo "$1") = "mainnet" ]; then 
  echo "starting mainnet"
  exec su-exec bitcoin bitcoind $defcmd -rpcuser=$2 -rpcpassword=$3
fi

# cmd -> reindexm
if [ $(echo "$1") = "reindexm" ]; then 
  echo "starting reindex"
  exec su-exec bitcoin bitcoind -reindex
fi

# cmd -> mnsync
if [ $(echo "$1") = "mnsync" ]; then 
  echo "starting mnsync status"
  exec su-exec bitcoin bitcoin-cli mnsync status
fi