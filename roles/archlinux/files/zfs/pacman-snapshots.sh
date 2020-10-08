#!/usr/bin/env bash

DATE="$(date --utc --iso-8601=seconds)"
EPOCH="$(date --utc --date "$DATE" +%s)"
SNAPSHOT_DATE="$(date --utc --date "$DATE" +%Y%m%dT%H%M%SZ)"
# datasets you'd like to take snapshots of. note '-r' is used to take snapshots recursively
DATASETS=( \
    zroot/ROOT/default
)
# how many days you'd like to keep the snapshots
KEEP_DAYS=7
KEEP_SECONDS=$(( KEEP_DAYS * 24 * 3600 ))
# skip taking new snapshots if the last one was taken within THROTTLE_SECONDS
THROTTLE_SECONDS=900
# prefix of snapshot names, make sure it doesn't conflict with others
SNAPSHOT_PREFIX="pacman"

# input: a/b@pacman-20181212T211523Z
# output: 2018-12-12 21:15:23
function get_snapshot_date() {
    snapshot_name="$1"
    # shellcheck disable=SC2001
    snapshot_date="$(sed "s/.*$SNAPSHOT_PREFIX-\(....\)\(..\)\(..\)T\(..\)\(..\)\(..\)Z/\1-\2-\3 \4:\5:\6/" <<< "$snapshot_name")"
    printf '%s' "$snapshot_date"
}

# input: a/b@pacman-20181212T211523Z
# output: 1544609723
function get_snapshot_epoch() {
    snapshot_name="$1"
    # shellcheck disable=SC2001
    snapshot_date="$(get_snapshot_date "$snapshot_name")"
    snapshot_epoch="$(date --utc --date "$snapshot_date" +%s)"
    printf '%s' "$snapshot_epoch"
}

last_snapshot="$(zfs list -t snapshot -S creation -o name -H | rg "@$SNAPSHOT_PREFIX" | head -n 1)"
if [[ -n "$last_snapshot" ]]; then
    last_snapshot_epoch="$(get_snapshot_epoch "$last_snapshot")"
    if [[ $(( EPOCH - last_snapshot_epoch )) -lt "$THROTTLE_SECONDS" ]]; then
        printf 'Last snapshot %s was created at %s (%s), skipping creating new ones\n' "$last_snapshot" "$(get_snapshot_date "$last_snapshot")" "$last_snapshot_epoch"
        exit 0
    fi
fi

zfs list -t snapshot -S creation -o name -H | rg "@$SNAPSHOT_PREFIX" | while read -r snapshot; do
    snapshot_epoch="$(get_snapshot_epoch "$snapshot")"
    if [[ $(( EPOCH - snapshot_epoch )) -gt $KEEP_SECONDS ]]; then
        printf 'Destroying snapshot %s\n' "$snapshot"
        zfs destroy "$snapshot"
    else
        # remove this if it's too annoying
        printf 'Keeping snapshot %s created at %s (%s)\n' "$snapshot" "$(get_snapshot_date "$snapshot")" "$snapshot_epoch"
    fi
done

for dataset in "${DATASETS[@]}"; do
    snapshot="$dataset@$SNAPSHOT_PREFIX-$SNAPSHOT_DATE"
    printf 'Creating snapshot %s\n' "$snapshot"
    zfs snapshot -r "$snapshot"
done