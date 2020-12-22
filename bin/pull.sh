#!/bin/bash -e

. $(dirname $0)/setenv.sh

cd $WD

[ -d repo ] || mkdir repo
cd repo

while read repo; do
	[ -d "${repo}" ] && pushd "$repo" && git pull "$@" && popd
done < $BIN/services
