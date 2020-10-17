#!/bin/bash -ex

cd $(dirname $0)/..
WD=$(pwd)

export MNT="$WD/mnt"

cd repo
while read repo; do
	pushd "$repo"
	bin/run.sh "$@"
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
_EOT_
