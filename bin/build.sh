#!/bin/bash -e

. $(dirname $0)/setenv.sh

cd $WD/repo

while read repo; do
	pushd "$repo" || continue
	bin/build.sh
	popd
done < $BIN/services

