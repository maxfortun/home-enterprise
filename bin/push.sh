#!/bin/bash -e

cd $(dirname $0)/..

[ -d repo ] || mkdir repo
cd repo

while read repo; do
	[ -d "${repo}" ] && pushd "$repo" && git push "$@" && popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
	dns-config
	docker-bind
	docker-certbot-dns
	docker-openldap
	docker-tor
_EOT_
