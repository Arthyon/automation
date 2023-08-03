#!/bin/bash

XRANDR=$(which xrandr)

MONITORS=( $( ${XRANDR} | awk '( $2 == "connected" ){ print $1 }' ) )


NUM_MONITORS=${#MONITORS[@]}

TITLES=()
COMMANDS=()
CURRENT_MONITOR=$(i3-msg -t get_workspaces | jq -rc '.[] | select(.focused) | .output' | head)

function generate_command()
{
    selected=$1

    cmd="i3-msg move workspace to output ${MONITORS[$selected]}"

    echo $cmd
}



declare -i index=0
TILES[$index]="Cancel"
COMMANDS[$index]="true"
index+=1
CURRENT_MONITOR_INDEX=0


for entry in $(seq 0 $((${NUM_MONITORS}-1)))
do
    TILES[$index]="${MONITORS[$entry]}"
    COMMANDS[$index]=$(generate_command $entry)
    if [ "${MONITORS[$entry]}" = "$CURRENT_MONITOR" ];
    then
        CURRENT_MONITOR_INDEX=$index+1
    fi
    index+=1
done


#  Generate entries, where first is key.
##
function gen_entries()
{
    for a in $(seq 0 $(( ${#TILES[@]} -1 )))
    do
        echo $a ${TILES[a]}
    done
}

# Call menu
SEL=$( gen_entries | rofi -dmenu -p "Move workspace to monitor" -a $CURRENT_MONITOR_INDEX -selected-row $CURRENT_MONITOR_INDEX -no-custom  | awk '{print $1}' )

# Call i3-msg
$( ${COMMANDS[$SEL]} )
