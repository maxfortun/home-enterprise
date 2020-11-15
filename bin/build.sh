#!/bin/bash -e

cd $(dirname $0)/../repo

while read repo; do
	pushd "$repo" || continue
	bin/build.sh
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
	dns-config
	docker-bind
	docker-certbot-dns
	docker-openldap
_EOT_
