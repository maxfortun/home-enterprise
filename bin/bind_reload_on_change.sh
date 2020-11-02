#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

GUEST_MNT=${GUEST_MNT:-$BWD/mnt}

DEST="$GUEST_MNT/etc/bind/zones"

while read zoneFile; do
	zone=$(basename $zoneFile)
	[ -f "$BWD/repo/dns-config/zones/$zone" ] || continue
	docker exec bind kill -HUP 1
done < <( fswatch "$DEST" )
