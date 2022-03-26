#!/usr/bin/python

import sys
import os
from os import listdir
from os.path import isfile, join
import subprocess


def filesMinusExtension(path):
    # os.path.splitext(f)[0] map with filename without extension with checking if file exists.
    files = [os.path.splitext(f)[0]
             for f in listdir(path) if isfile(join(path, f))]
    return files


homePath = os.path.expanduser('~')
layoutsPath = f'{homePath}/.screenlayout'

if len(sys.argv) == 1:
    files = filesMinusExtension(layoutsPath)
    print(*files, sep="\n")
else:
    devnull = open(os.devnull, 'wb')
    subprocess.Popen(
        [f'{layoutsPath}/{sys.argv[1]}.sh && ~/.config/polybar/launch.sh'], stdout=devnull, stderr=devnull)
