#!/bin/bash
# creates a list of 32 char hex api keys for use with idena-node-proxy as well as for sending to idena devs for inclusion on the rental node page
# usage: ./apikeys.sh NUMBER_OF_KEYS EPOCH
# for example: ./apikeys 100 71

if [[ $# -eq 0 ]] ; then
    echo 'ERROR: You have not supplied the required arguments'
    echo 'USAGE: ./apikeys.sh NUMBER_OF_KEYS EPOCH'
    exit 1
fi

if [[ $# -eq 1 ]] ; then
    echo 'ERROR: You are missing an argument'
    echo 'USAGE: ./apikeys.sh NUMBER_OF_KEYS EPOCH'
    exit 1
fi

for ((i = 1; i <= $1; i++)); do hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/urandom | awk '{print tolower($0)}'; done > keys.txt
sed 's/.*/"&",/' keys.txt > keys2.txt
sed -z 's/\n//g' keys2.txt > keysconfig_$2.txt
sed s/$/,$2/ keys.txt > keysdevs_$2.txt
echo "DONE: $1 API keys created for epoch $2"
echo "paste the contents of keysconfig_$2.txt into the approriate location of idena-node-proxy configuration and restart the proxy"
echo "send the keysdevs_$2.txt file to the idena developers in the way they proposed"
