#!/bin/bash -ex
host=$1
port=$2
guest=$3

if [ -z "$guest" ]; then
	echo "Usage: $0 <host> <port> <local hostname>"
	echo "e.g.: $0 server.example.com 10222 server"
	exit 1
fi

scp -P $port mnt/$(hostname -s)/root/.ssh/id_rsa.pub $host:home-enterprise/mnt/$guest/root/.ssh/authorized_keys
