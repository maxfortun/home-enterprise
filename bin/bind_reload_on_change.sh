#!/bin/bash -ex

. $(dirname $0)/setenv.sh

$BIN/plock.sh $(basename $0) $$

export HOST_MNT="$WD/mnt"
export GUEST_MNT="$HOST_MNT/$(hostname -s)"

DEST="$GUEST_MNT/etc/bind/zones"

while read zoneFile; do
	zone=$(basename $zoneFile)
	[ -f "$WD/repo/dns-config/zones/$zone" ] || continue
	docker exec bind kill -HUP 1
done < <( fswatch "$DEST" )
