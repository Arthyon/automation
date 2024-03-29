#!/bin/bash
if [ ! -n "$BASHMARKS" ]; then
    BASHMARKS=~/.config/bashmarks/marks
fi
touch $BASHMARKS
RED="0;31m"
GREEN="0;33m"

_bookmark_name_valid() {
    exit_message=""
    if [ -z $1 ]; then
        exit_message="bookmark name required"
        echo $exit_message
    elif [ "$1" != "$(echo $1 | sed 's/[^A-Za-z0-9_]//g')" ]; then
        exit_message="bookmark name is not valid"
        echo $exit_message
    fi
}

_purge_line() {
    if [ -s "$1" ]; then
        t="/tmp/.z.tmp"
        trap "rm -f -- '$t'" EXIT

        sed "/$2/d" "$1" > "$t"
        mv "$t" "$1"

        rm -f -- "$t"
        trap - EXIT
    fi
}

jump() {
	source $BASHMARKS
	target="$(eval $(echo echo $(echo \$DIR_$1)))"
	cd "$target"
}

list() {
	source $BASHMARKS
	env | sort | awk '/DIR_.+/{split(substr($0,5),parts,"="); printf("\033[0;33m%-20s\033[0m %s\n", parts[1], parts[2]);}'
}

_l() {
    source $BASHMARKS
    env | grep "^DIR_" | cut -c5- | sort | grep "^.*=" | cut -f1 -d "=" 
}

mark() {
	_bookmark_name_valid "$@"
    if [ -z "$exit_message" ]; then
        _purge_line "$BASHMARKS" "export DIR_$1="
        CURDIR=$(echo $PWD| sed "s#^$HOME#\$HOME#g")
        echo "export DIR_$1=\"$CURDIR\"" >> $BASHMARKS
    fi
}

unmark() {
	_bookmark_name_valid "$@"
	if [ -z "$exit_message" ]; then
	    _purge_line "$BASHMARKS" "export DIR_$1="
	    unset "DIR_$1"
	fi
}

_comp () {
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W '`_l`' -- $curw))
    return 0
}

#complete -F _comp jump
#complete -F _comp unmark
