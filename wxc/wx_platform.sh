#!/bin/sh
# Outputs the current wxWidgets platform (from wx-config)
wx-config --cflags $* | sed -e 's/.*\-D__\(WX.*\)__.*/\1/'
