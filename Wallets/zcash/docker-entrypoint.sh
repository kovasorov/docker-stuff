#!/bin/sh
set -e

# постоянные параметры
defcmd="-datadir=/root/.zcash -discover -printtoconsole -txindex -rpcbind=0.0.0.0 -rpcallowip=yourserver.ip/16 -rpcthreads=128"

# making datadir
mkdir -p "$ZCASH_HOME/.zcash"
touch "$ZCASH_HOME/.zcash/zcash.conf"
chmod 700 "$ZCASH_HOME/.zcash"
echo "$0: setting data directory to $ZCASH_HOME/.zcash"

# cmd -> bash
if [ "$1" = "bash" ]; then 
  echo "starting bash"
  exec bash
fi

# cmd -> reindext
if [ $(echo "$1") = "reindext" ]; then 
  echo "starting reindex"
  exec zcashd -testnet -reindex
fi

# cmd -> testnet user password
if [ $(echo "$1") = "testnet" ]; then 
  echo "starting testnet"
  exec zcashd $defcmd -$1 -rpcuser=$2 -rpcpassword=$3 -addnode=testnet.z.cash
fi

# cmd -> mainnet user password
if [ $(echo "$1") = "mainnet" ]; then 
  echo "starting mainnet"
  exec zcashd $defcmd -rpcuser=$2 -rpcpassword=$3 -addnode=mainnet.z.cash
fi

# cmd -> reindexm
if [ $(echo "$1") = "reindexm" ]; then 
  echo "starting reindex"
  exec zcashd -reindex
fi

# cmd -> mnsync
if [ $(echo "$1") = "mnsync" ]; then 
  echo "starting mnsync status"
  exec zcash-cli mnsync status
fi