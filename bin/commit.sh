#!/bin/bash -e

cd $(dirname $0)/..

[ -d repo ] || mkdir repo
cd repo

while read repo; do
	[ -d "${repo}" ] && pushd "$repo" && git commit "$@" && popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
_EOT_
