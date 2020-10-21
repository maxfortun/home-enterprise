#!/bin/bash -e

cd $(dirname $0)/..

[ -d repo ] || mkdir repo
cd repo

while read repo; do
	[ -d "${repo}" ] && pushd "$repo" && git commit "$@" || true && popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
	dns-config
	docker-bind
	docker-dkimproxy
_EOT_
