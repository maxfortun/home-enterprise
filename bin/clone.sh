#!/bin/bash -e

cd $(dirname $0)/..

[ -d repo ] || mkdir repo
cd repo

while read repo; do
	[ -d "${repo}" ] || git clone "https://github.com/maxfortun/${repo}.git"
done <<_EOT_
	docker-sshd
	docker-lsyncd
_EOT_