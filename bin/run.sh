#!/bin/bash -ex

cd $(dirname $0)/..
. bin/setenv.sh

dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/"//g' > $GUEST_MNT/public_ip

cd repo
while read repo; do
	pushd "$repo" || continue
	bin/run.sh "$@"
	popd
done <<_EOT_
	docker-sshd
	docker-lsyncd
	dns-config
	docker-bind
	docker-certbot-dns
	docker-openldap
	docker-tor
_EOT_
