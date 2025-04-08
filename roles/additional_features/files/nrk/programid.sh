#!/bin/bash

if [ ! -z "$@" ]
then
    # add additional tabs here
    xdg-open "https://tv.nrk.no/program/$@" >/dev/null
    exit 0
fi
echo "Enter a program id"
