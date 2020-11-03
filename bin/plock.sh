#!/bin/bash -e

label=$1
pid=$2

if [ -z "$label" ]; then
	echo "Acquires or releases a lock for a <label>."
	echo "Usage: $0 <label> [pid]"
	echo "Acquire: $0 <label> <pid>"
	echo "Release: $0 <label>"
	echo "On success exits normally."
	echo "On error exits with 1."
	echo "Note: <label> may not contain slashes."
	exit 1
fi

if [ "${label//\//}" != "${label}" ]; then
	echo "Label may not contain slashes: $label" >&2
	exit 1
fi

PLOCK_HOME=${PLOCK_HOME:-/tmp}
PLOCK_DIR="$PLOCK_HOME/$label"

if [ -z "$pid" ] && [ -d  "$PLOCK_DIR" ]; then
	rm -rf "$PLOCK_DIR"
	exit
fi

if [ ! -d "$PLOCK_DIR" ]; then
	mkdir "$PLOCK_DIR"
	echo "$pid" > "$PLOCK_DIR/pid"
	exit
fi

locked=$(cat $PLOCK_DIR/pid || true)
if [ "$locked" = "$pid" ]; then
	exit
fi

if [ -n "$locked" ] && ps -opid= "$locked" >/dev/null; then
	exit 1
fi

rm -rf "$PLOCK_DIR"
mkdir "$PLOCK_DIR"
echo "$pid" > "$PLOCK_DIR/pid"

