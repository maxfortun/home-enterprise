#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

GUEST_MNT=${GUEST_MNT:-$BWD/mnt}

DEST="$GUEST_MNT/etc/bind/zones"

while read zoneFile; do
	zone=$(basename $zoneFile)
	[ -f "$BWD/zones/$zone" ] || continue
	docker exec bind rndc reload $zone
done < <( fswatch "$DEST" )
