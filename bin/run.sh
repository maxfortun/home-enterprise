#!/bin/bash -ex

. $(dirname $0)/setenv.sh

cd $WD

dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/"//g' > $GUEST_MNT/public_ip

cd repo
while read repo; do
	pushd "$repo" || continue
	bin/run.sh "$@"
	popd
done < $BIN/services
