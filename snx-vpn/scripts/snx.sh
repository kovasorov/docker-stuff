#!/bin/bash
server=$SNX_SERVER
user=$SNX_USER
password=$SNX_PASSWORD

/usr/bin/expect <<EOF
spawn snx -s $server -u $user
expect "*?assword:"
send "$password\r"
expect "*Do you accept*"
send "y\r"
expect "SNX - connected."
interact
EOF

ip add sh dev tunsnx
route add -net yourserver.ip netmask 255.255.255.0 dev tunsnx

/bin/bash
