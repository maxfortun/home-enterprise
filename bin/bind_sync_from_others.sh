#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

export HOST_MNT="$BWD/mnt"
export GUEST_MNT="$HOST_MNT/$(hostname -s)"

paths=$(ls -d $HOST_MNT/* | grep -v $( hostname -s )\$ )

while read zoneFile; do
	zone=$(basename $zoneFile)
	[ -f "$BWD/repo/dns-config/zones/$zone" ] || continue
	DEST=${zoneFile#$HOST_MNT}
	DEST=$GUEST_MNT/${DEST#/*/}
	continue
	diff $zoneFile $DEST && continue
	cp -a $zoneFile $DEST
done < <( fswatch $paths )