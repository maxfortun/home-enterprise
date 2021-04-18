#!/bin/bash -ex
host=$1
port=$2
guest=$3
scp -P $port mnt/$(hostname -s)/root/.ssh/id_rsa.pub $host:home-enterprise/mnt/$guest/root/.ssh/authorized-keys
