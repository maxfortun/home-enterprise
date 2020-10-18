#!/bin/bash -ex

cd $(dirname $0)/..
WD=$(pwd)

export MNT="$WD/mnt"
export HOST_MNT="$MNT/$(hostname -s)"

cd repo
while read repo; do
	pushd "$repo"
	bin/run.sh "$@"
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
_EOT_
