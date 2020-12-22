#!/bin/bash -e

. $(dirname $0)/setenv.sh

cd $WD

[ -d repo ] || mkdir repo
cd repo

while read repo; do
	[ -d "${repo}" ] || git clone "https://github.com/maxfortun/${repo}.git"
done < $BIN/services

