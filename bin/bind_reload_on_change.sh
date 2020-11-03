#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")

$SWD/plock.sh $(basename $0) $$

export HOST_MNT="$BWD/mnt"
export GUEST_MNT="$HOST_MNT/$(hostname -s)"

DEST="$GUEST_MNT/etc/bind/zones"

while read zoneFile; do
	zone=$(basename $zoneFile)
	[ -f "$BWD/repo/dns-config/zones/$zone" ] || continue
	docker exec bind kill -HUP 1
done < <( fswatch "$DEST" )
