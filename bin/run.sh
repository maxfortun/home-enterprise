#!/bin/bash -ex

cd $(dirname $0)/..
WD=$(pwd)

export HOST_MNT="$WD/mnt"
export GUEST_MNT="$HOST_MNT/$(hostname -s)"

dig TXT +short o-o.myaddr.l.google.com @ns1.google.com > $GUEST_MNT/public_ip

cd repo
while read repo; do
	pushd "$repo" || continue
	bin/run.sh "$@"
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
	dns-config
	docker-bind
_EOT_
