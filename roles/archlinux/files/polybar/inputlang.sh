#!/bin/bash

# Shell script to print current keyboard language
lang=`setxkbmap -query | awk '/layout/{print $2}'`
echo "" ${lang^^};
