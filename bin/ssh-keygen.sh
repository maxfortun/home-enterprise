#!/bin/bash -ex

. $(dirname $0)/setenv.sh

ssh-keygen -b 2048 -t rsa -f $GUEST_MNT/root/.ssh/id_rsa -q -N ""

