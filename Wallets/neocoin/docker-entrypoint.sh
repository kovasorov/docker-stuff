#!/bin/sh

cd /opt/neo-cli

PATH=/opt/dotnet:$PATH
export PATH

if [ "$1" = "testnet" ]; then
  echo "Use testnet"
  rm -f protocol.json
  rm -f config.json
  cp protocol.testnet.json protocol.json
  cp config.testnet.json config.json
fi

sed -i 's/"Chain_{0}"/"myneodata\/Chain_{0}"/g' ./config.json
sed -i 's/"ApplicationLogs_{0}"/"myneodata\/ApplicationLogs_{0}"/g' ./config.json

#exec dotnet neo-cli.dll /rpc

FILE_WP="/opt/neo-cli/myneodata/mywp.txt"
EXEC_CMD=""

if [ ! -f "$FILE_WP" ]; then
	cat /dev/urandom | tr -dc 'a-zA-Z0-9_=,;:+#@%*!?' | fold -w 48 | head -n 1 > "$FILE_WP"
	EXEC_CMD="create"
fi

exec /exec_neo.expect "$EXEC_CMD"