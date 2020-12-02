export WD=$( cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 ; pwd -P )
export HOST_MNT="$WD/mnt"
export GUEST_MNT="$HOST_MNT/$(hostname -s)"

for script in $(dirname ${BASH_SOURCE[0]})/setenv-*.sh; do
        . $script
done

