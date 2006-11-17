#!/bin/sh
if [ "x$WX_CONFIG" = "x" ]; then WX_CONFIG=wx-config; fi
# Outputs the current wxWidgets platform (from wx-config)
$WX_CONFIG --cflags $@ | sed -e 's/.*\-D__\(WX.*\)__.*/\1/'
