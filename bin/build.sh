#!/bin/bash -e

cd $(dirname $0)/../repo

while read repo; do
	pushd "$repo"
	bin/build.sh
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
_EOT_
