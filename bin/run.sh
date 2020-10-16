#!/bin/bash -e

cd $(dirname $0)/../repo

while read repo; do
	pushd "$repo"
	bin/run.sh
	popd
done <<_EOT_
	docker-lsyncd
_EOT_
