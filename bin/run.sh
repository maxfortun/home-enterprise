#!/bin/bash -ex

cd $(dirname $0)/..
WD=$(pwd)

export HOST_MNT="$WD/mnt"
export GUEST_MNT="$MNT/$(hostname -s)"

cd repo
while read repo; do
	pushd "$repo"
	bin/run.sh "$@"
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
_EOT_
