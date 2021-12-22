#!/bin/bash
# creates a list of 32 char hex api keys for use with idena-node-proxy
# usage: ./apikeys.sh NUMBER_OF_KEYS SIZE_OF_STRING
# for example: ./apikeys_priv.sh 100 5

if [[ $# -eq 0 ]] ; then
    echo 'ERROR: You have not supplied the required arguments'
    echo 'USAGE: ./apikeys_priv.sh NUMBER_OF_KEYS SIZE_OF_STRING'
    exit 1
fi

if [[ $# -eq 1 ]] ; then
    echo 'ERROR: You are missing an argument'
    echo 'USAGE: ./apikeys_priv.sh NUMBER_OF_KEYS SIZE_OF_STRING'
    exit 1
fi

for ((i = 1; i <= $1; i++)); do cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c $2; echo; done > keys_priv_$1_$2.txt
sed 's/.*/"&",/' keys_priv_$1_$2.txt > keys_priv_$1_$2_2.txt
sed -z 's/\n//g' keys_priv_$1_$2_2.txt > keysconfig_priv_$1_$2.txt
echo "DONE: $1 API keys created of size $2"
echo "paste the contents of keys_priv_$1_$2.txt into the approriate location of idena-node-proxy configuration and restart the proxy"
