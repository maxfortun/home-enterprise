#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

HOST_MNT=${HOST_MNT:-$BWD/mnt}

paths=$(ls -d $HOST_MNT/* | grep -v $( hostname -s )\$ )

while read zoneFile; do
	zone=$(basename $zoneFile)
	[ -f "$BWD/zones/$zone" ] || continue
	diff $zoneFile $BWD/zones/$zone && continue
	cp -a $zoneFile $BWD/zones/$zone
done < <( fswatch $paths )
